---
title: Cloudwatch Logs
weight: 99

---
# Extract logs from Cloudwatch

```python
from itertools import zip_longest, groupby
from collections import Counter
import csv

import boto3

LOG_NAME = 'my-app'


def main():
    session = boto3.Session(profile_name="prod")
    logs_client = session.client('logs')

    groups = [
        group
        for page in logs_client.get_paginator('describe_log_groups').paginate()
        for group in page['logGroups']
        if LOG_NAME in group['logGroupName']
    ]

    group_streams = [
        (
            group,
            [
                stream
                for page in logs_client.get_paginator('describe_log_streams').paginate(logGroupName=group['logGroupName'])
                for stream in page['logStreams']
            ]
        )
        for group in groups
    ]

    events = [
        event
        for group, streams in group_streams
        for stream_chunk in grouper(streams, 100)
        for page in logs_client.get_paginator('filter_log_events').paginate(
            logGroupName=group['logGroupName'],
            logStreamNames=[stream['logStreamName'] for stream in stream_chunk],
            filterPattern='warning sent',
        )
        for event in page['events']
    ]

    messages = [e['message'] for e in events]

    def extractfunc(message):
        return tuple(message.strip().split()[4:6][::-1])

    def transformfunc(row):
        tag, count = row
        return tag[0], 10 * count

    def aggregatekeyfunc(row):
        return row[0]

    def aggregatefunc(row):
        k, groups = row
        values = [g[1] for g in groups]
        total, ammount = sum(values), len(values)
        return k, total, ammount, total/ammount

    def sortedfunc(row):
        return row[1]

    counts = Counter(extractfunc(m) for m in messages)
    items = sorted(transformfunc(r) for r in counts.items())
    aggregated = [
        aggregatefunc(r)
        for r in groupby(items, key=aggregatekeyfunc)
    ]
    rank = sorted(aggregated, key=sortedfunc, reverse=True)
    with open('report.txt', mode='w', newline='') as f:
        w = csv.writer(f)
        w.writerow(("name", "total", "ammount", "average"))
        w.writerows(rank)


def grouper(iterable, n, fillvalue=None):
    "Collect data into fixed-length chunks or blocks"
    # grouper('ABCDEFG', 3, 'x') --> ABC DEF Gxx"
    args = [iter(iterable)] * n
    for batch in zip_longest(*args, fillvalue=fillvalue):
        yield [*filter(None.__ne__, batch)]


if __name__ == '__main__':
    main()
```
