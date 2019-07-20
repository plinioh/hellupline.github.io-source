---
title: Secret Example
tags:
- config-files
- example
weight: 3

---
# Secret Example

```yaml
apiVersion: v1
kind: Secret
metadata:
    labels: {app: my-app}
    name: my-app
    namespace: my-namespace
type: Opaque
stringData:
    CONFIG_ENV: my-config-valye
    CONFIG_FILE: |
        {
            "key_01": "value_02",
            "key_02": "value_02",
        }
---
```