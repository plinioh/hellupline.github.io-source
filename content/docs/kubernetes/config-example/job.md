---
title: Job
weight: 11

---
# Job Example

```yaml
apiVersion: batch/v1
kind: Job
metadata:
    labels: {app: my-job}
    name: my-job
    namespace: my-namespace
spec:
    template:
        metadata: {labels: {app: my-job}}
        spec:
            restartPolicy: Never
            containers:
              - name: my-job
                image: alpine
                imagePullPolicy: Always
                command: ["echo", "hello", "nurse"]
```
