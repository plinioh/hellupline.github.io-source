#!/bin/sh

set -o pipefail # exit on pipeline error
set -e # exit on error
set -u # variable must exist
set -x # verbose


{ [ ! -f regions.json ] && aws ec2 describe-regions > "regions.json"; cat "regions.json"; } |
    jq --raw-output '.Regions[].RegionName' |
    while read REGION; do
        { [ ! -f "ami_${REGION}.json" ] && aws --region "${REGION}" ec2 describe-images --owners amazon > "ami_${REGION}.json"; cat "ami_${REGION}.json"; } |
            jq --arg region ${REGION} '. + $ARGS.named'
    done | jq --slurp --arg ami "Amazon Linux 2 AMI 2" '
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
