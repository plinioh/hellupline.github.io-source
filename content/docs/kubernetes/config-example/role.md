---
title: Deployment
weight: 1

---
# Deployment Example

```yaml
---
kind: Role
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: my-user--full-access
  namespace: my-namespace
rules:
- apiGroups: ["", "extensions", "apps"]
  resources: ["*"]
  verbs: ["*"]
- apiGroups: ["batch"]
  resources:
  - jobs
  - cronjobs
  verbs: ["*"]

---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: my-user
  namespace: my-namespace

---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: my-user-view
  namespace: my-namespace
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: my-user--full-access
subjects:
- kind: ServiceAccount
  name: my-user
  namespace: my-namespace
```