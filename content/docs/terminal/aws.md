---
title: AWS CLI Tools
weight: 99

---

# AWS CLI Tools

## List Parameters and filter results with JQ

```bash
aws ssm describe-parameters --profile EXAMPLE_PROFILE --region DESIRED_REGION | jq '.Parameters[] | select(.Name | test("YOUR_REGULAR_EXPRESSION_HERE))'
```
