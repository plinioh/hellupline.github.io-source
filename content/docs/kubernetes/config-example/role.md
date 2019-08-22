---
title: RBAC
weight: 7

---
# Cluster Level Role-Based Access Control Example

[Offical Docs](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)

## Full Access Example

```yaml
---
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
    name: my-role--full-access
rules:
  - apiGroups: ["", "extensions", "apps", "batch"]
    resources: ["*"]
    verbs: ["*"]

---
apiVersion: v1
kind: ServiceAccount
metadata:
    name: my-service-account
    namespace: my-namespace

---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
    name: my-user-view
roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: my-role--full-access
subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: ServiceAccount
    name: my-service-account
    namespace: my-namespace
  - apiGroup: rbac.authorization.k8s.io
    kind: User
    name: my-user
  - apiGroup: rbac.authorization.k8s.io
    kind: Group
    name: my-group
```

## Read Only Example

```yaml
---
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
    name: my-role--read-only
rules:
  - apiGroups: ["", "extensions", "apps", "batch"]
    resources: ["*"]
    verbs: ["*"]

---
apiVersion: v1
kind: ServiceAccount
metadata:
    name: my-service-account
    namespace: my-namespace

---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
    name: my-user-view
roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: my-role--read-only
subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: ServiceAccount
    name: my-service-account
    namespace: my-namespace
  - apiGroup: rbac.authorization.k8s.io
    kind: User
    name: my-user
  - apiGroup: rbac.authorization.k8s.io
    kind: Group
    name: my-group
```

# Namespace Level Role-Based Access Control Example

## Full Access Example

```yaml
---
kind: Role
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
    name: my-role--full-access
    namespace: my-namespace
rules:
  - apiGroups: ["", "extensions", "apps", "batch"]
    resources: ["*"]
    verbs: ["*"]

---
apiVersion: v1
kind: ServiceAccount
metadata:
    name: my-service-account
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
    name: my-role--full-access
subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: ServiceAccount
    name: my-service-account
    namespace: my-namespace
  - apiGroup: rbac.authorization.k8s.io
    kind: User
    name: my-user
    namespace: my-namespace
  - apiGroup: rbac.authorization.k8s.io
    kind: Group
    name: my-group
    namespace: my-namespace
```

## Read Only Example

```yaml
---
kind: Role
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
    name: my-role--read-only
    namespace: my-namespace
rules:
  - apiGroups: ["", "extensions", "apps", "batch"]
    resources: ["*"]
    verbs: ["*"]

---
apiVersion: v1
kind: ServiceAccount
metadata:
    name: my-service-account
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
    name: my-role--read-only
subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: ServiceAccount
    name: my-service-account
    namespace: my-namespace
  - apiGroup: rbac.authorization.k8s.io
    kind: User
    name: my-user
    namespace: my-namespace
  - apiGroup: rbac.authorization.k8s.io
    kind: Group
    name: my-group
    namespace: my-namespace
```


# Aggregated Role

```yaml
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: monitoring
aggregationRule:
  clusterRoleSelectors:
  - matchLabels:
      rbac.example.com/aggregate-to-monitoring: "true"
rules: [] # Rules are automatically filled in by the controller manager.

---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: monitoring-endpoints
  labels:
    rbac.example.com/aggregate-to-monitoring: "true"
# These rules will be added to the "monitoring" role.
rules:
- apiGroups: [""]
  resources: ["services", "endpoints", "pods"]
  verbs: ["get", "list", "watch"]
```

# Common Subjects

## For a user named “alice@example.com”:

```yaml
subjects:
- kind: User
  name: "alice@example.com"
  apiGroup: rbac.authorization.k8s.io
```

## For a group named “frontend-admins”:

```yaml
subjects:
- kind: Group
  name: "frontend-admins"
  apiGroup: rbac.authorization.k8s.io
```

## For the default service account in the kube-system namespace:

```yaml
subjects:
- kind: ServiceAccount
  name: default
  namespace: kube-system
```

## For all service accounts in the “qa” namespace:

```yaml
subjects:
- kind: Group
  name: system:serviceaccounts:qa
  apiGroup: rbac.authorization.k8s.io
```

## For all service accounts everywhere:

```yaml
subjects:
- kind: Group
  name: system:serviceaccounts
  apiGroup: rbac.authorization.k8s.io
```

## For all authenticated users (version 1.5+):

```yaml
subjects:
- kind: Group
  name: system:authenticated
  apiGroup: rbac.authorization.k8s.io
```

## For all unauthenticated users (version 1.5+):

```yaml
subjects:
- kind: Group
  name: system:unauthenticated
  apiGroup: rbac.authorization.k8s.io
```

## For all users (version 1.5+):

```yaml
subjects:
- kind: Group
  name: system:authenticated
  apiGroup: rbac.authorization.k8s.io
- kind: Group
  name: system:unauthenticated
  apiGroup: rbac.authorization.k8s.io
```