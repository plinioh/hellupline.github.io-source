---
title: Ami Per Region
weight: 99

---
# Ami Per Region

```bash
aws ec2 describe-regions | jq --raw-output '.Regions[].RegionName' | \
    while read REGION; do
        aws ec2 describe-images --owners amazon --region ${REGION} | \
            jq --arg REGION ${REGION} '. + {"region": $ARGS.named.REGION}'
    done | \
        jq -s '[.[] | . as $region | $region.Images[] | select(.Description // "" | contains("Amazon Linux 2 AMI 2.0.20190618 x86_64 HVM gp2")) | {"key": $region.region, "value": {"AMI": .ImageId}}] | from_entries' | \
        xclip -in -selection clipboard
```
