#!/bin/sh

set -o pipefail # exit on pipeline error
set -e # exit on error
set -u # variable must exist
set -x # verbose


aws ec2 describe-regions | jq --raw-output '.Regions[].RegionName' | \
    while read REGION; do
        aws ec2 describe-images --owners amazon --region ${REGION} | \
        jq --arg region ${REGION} '. + $ARGS.named'
    done | \
    jq --slurp --arg ami "Amazon Linux 2 AMI 2" '
        map(
            .region as $region
            | .Images
            | map(select(.Description // "" | contains("x86_64 HVM gp2")))
            | map(select(.Description // "" | contains($ARGS.named.ami)))
            | map({ "key": $region, "value": { "Description": .Description, "AMI": .ImageId, "CreationDate": .CreationDate, }, })
            | sort_by(.value.CreationDate)
            | .[-1]
        ) | from_entries
    '
