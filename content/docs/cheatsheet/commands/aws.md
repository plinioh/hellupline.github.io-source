---
title: AWS
weight: 999
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---


## List Instance and Private IPs, Filter by beanstalk environment

```
aws --profile=default --region=us-east-1 ec2 describe-instances
         --filter "Name=tag:elasticbeanstalk:environment-name,Values=my-app" | \
   jq --raw-output '
      .Reservations[].Instances[] | [.InstanceId, .PrivateIpAddress] | @csv'
```


## List Elastic Ips

```
aws --profile=default --region=us-east-1 ec2 describe-addresses \
         --public-ips \
         --filter "Name=public-ip,Values=[10.0.0.1]" |
   jq --raw-output '
      .Addresses[] | [.PublicIp] | @csv'
```
