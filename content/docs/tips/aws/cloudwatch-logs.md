---
title: Cloudwatch Logs
weight: 99

---
# Extract logs from Cloudwatch

```python
from itertools import zip_longest

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

    counts = Counter(' '.join(m.strip().split(' ')[5:]) for m in messages)
    rank = sorted(counts.items(), key=lambda r: r[1], reverse=True)
    with open('report.txt', mode='w') as f:
        for name, count in rank:
            print(name, count, file=f)


def grouper(iterable, n, fillvalue=None):
    "Collect data into fixed-length chunks or blocks"
    # grouper('ABCDEFG', 3, 'x') --> ABC DEF Gxx"
    args = [iter(iterable)] * n
    for batch in zip_longest(*args, fillvalue=fillvalue):
        yield [*filter(None.__ne__, batch)]

if __name__ == '__main__':
    main()
```
