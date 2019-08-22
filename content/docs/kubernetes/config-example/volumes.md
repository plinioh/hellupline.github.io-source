---
title: Volumes
weight: 9

---
# Volumes Example

## Cloud Volume Example

```yaml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
    name: my-pvc
spec:
    resources: requests: {storage: 3Gi}
    accessModes: [ReadWriteOnce]

---
apiVersion: v1
kind: Pod
metadata:
    name: my-pvc-pod
spec:
    containers:
      - name: my-pvc-pod-nginx
        image: nginx
        volumeMounts:
          - {name: "my-pvc-data", mountPath: "/usr/share/nginx/html"}
        ports:
          - {name: "http", containerPort: 80}
    volumes:
      - {name: "my-pvc-data", persistentVolumeClaim: {claimName: "my-pvc"}}
```

## Local Disk Volume

```yaml
---
apiVersion: v1
kind: PersistentVolume
metadata:
    labels: {type: local}
    name: my-pv
spec:
    storageClassName: manual
    hostPath: {path: "/opt/volumes/my-pv"}
    capacity: {storage: 10Gi}
    accessModes: [ReadWriteOnce]

---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
    labels: {type: local}
    name: my-pvc
spec:
    storageClassName: manual
    selector: {matchLabels: {type: local}}
    resources: requests: {storage: 3Gi}
    accessModes: [ReadWriteOnce]

---
apiVersion: v1
kind: Pod
metadata:
    name: my-pvc-pod
spec:
    containers:
      - name: my-pvc-pod-nginx
        image: nginx
        volumeMounts:
          - {name: "my-pvc-volume", mountPath: "/usr/share/nginx/html"}
        ports:
          - {name: "http", containerPort: 80}
    volumes:
      - {name: "my-pvc-volume", persistentVolumeClaim: {claimName: "my-pvc"}}
```
