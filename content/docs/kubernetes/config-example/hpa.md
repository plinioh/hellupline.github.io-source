---
title: HPA
weight: 6

---
# Horizontal Pod Autoscaler Example

```yaml
apiVersion: autoscaling/v2beta2
kind: HorizontalPodAutoscaler
metadata:
    labels: {app: my-app}
    name: my-app
    namespace: default
spec:
    scaleTargetRef:
        apiVersion: apps/v1
        kind: Deployment
        name: my-app
    metrics:
      - type: Resource
        resource:
            name: cpu
            target:
                type: Utilization
                averageUtilization: 50
      - type: Object
        object:
            describedObject:
                apiVersion: networking.k8s.io/v1beta1
                kind: Ingress
                name: my-app
            metric:
                name: requests-per-second
            target:
                kind: Value
                value: 60
      - type: Pods
        pods:
            metric:
                name: packets-per-second
            target:
                type: AverageValue
                averageValue: 1k
    minReplicas: 1
    maxReplicas: 10
---
```