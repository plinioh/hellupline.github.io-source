---
title: RBAC
weight: 14

---

# Cluster Level Role-Based Access Control Example

[Offical Docs](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)

## Full Access Example

{{% code file="/resources/kubernetes/rbac-cluster-full-access.yaml" language="yaml" download="true" %}}

## Read Only Example

{{% code file="/resources/kubernetes/rbac-cluster-read-only.yaml" language="yaml" download="true" %}}

# Namespace Level Role-Based Access Control Example

## Full Access Example

{{% code file="/resources/kubernetes/rbac-namespace-full-access.yaml" language="yaml" download="true" %}}

## Read Only Example

{{% code file="/resources/kubernetes/rbac-namespace-read-only.yaml" language="yaml" download="true" %}}


# Aggregated Role

{{% code file="/resources/kubernetes/rbac-aggregated-maintenance.yaml" language="yaml" download="true" %}}

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