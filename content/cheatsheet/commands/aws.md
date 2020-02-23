---
title: aws
weight: 120
type: docs
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---

## list instance and private ips, filter by beanstalk environment

```bash
aws --profile=default --region=us-east-1 ec2 describe-instances
         --filter "Name=tag:elasticbeanstalk:environment-name,Values=my-app" | \
   jq --raw-output '
      .Reservations[].Instances[] | [.InstanceId, .PrivateIpAddress] | @csv'
```


## list elastic ips

```bash
aws --profile=default --region=us-east-1 ec2 describe-addresses \
         --public-ips \
         --filter "Name=public-ip,Values=[10.0.0.1]" |
   jq --raw-output '
      .Addresses[] | [.PublicIp] | @csv'
```


# describe rds, filter by cacertificate version

```bash
for PROFILE_NAME in "staging" "production"; do
    aws --profile="${PROFILE_NAME}" ec2 describe-regions |
        jq --raw-output '.Regions[].RegionName' |
        while read REGION_NAME; do
            aws --profile="${PROFILE_NAME}" --region="${REGION_NAME}" rds describe-db-instances |
                jq --raw-output '.DBInstances[] | select(.CACertificateIdentifier == "rds-ca-2019" or .PendingModifiedValues.CACertificateIdentifier == "rds-ca-2019" | not) | .DBInstanceIdentifier' |
                while read INSTANCE_NAME; do
                    echo "aws --profile='${PROFILE_NAME}' --region='${REGION_NAME}' rds modify-db-instance --db-instance-identifier '${INSTANCE_NAME}' --ca-certificate-identifier rds-ca-2019 --no-certificate-rotation-restart"
                    # echo ${PROFILE_NAME}, ${REGION_NAME}, ${INSTANCE_NAME}
                done
        done
done
```
