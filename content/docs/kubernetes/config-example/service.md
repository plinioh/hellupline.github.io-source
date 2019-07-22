---
title: Service
weight: 4

---
# Service Example

```yaml
apiVersion: v1
kind: Service
metadata:
    labels: {app: my-app}
    name: my-app
    namespace: my-namespace
spec:
    type: ClusterIP
    externalTrafficPolicy: Local
    selector: {app: my-app}
    ports:
      - {name: http, port: 80, protocol: TCP, targetPort: 8000}
---
```