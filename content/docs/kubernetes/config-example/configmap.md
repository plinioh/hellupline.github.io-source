---
title: ConfigMap
weight: 3

---
# ConfigMap Example

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
    labels: {app: my-app}
    name: my-app
    namespace: my-namespace
data:
    CONFIG_ENV: my-config-valye
    CONFIG_FILE: |
        {
            "key_01": "value_02",
            "key_02": "value_02",
        }
---
```