---
title: Deployment Example
tags:
- config-files
- example
weight: 1

---
# Deployment Example

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
    labels: {app: my-app}
    name: my-app
    namespace: my-namespace
spec:
    strategy: {rollingUpdate: {maxSurge: 1, maxUnavailable: 1}, type: RollingUpdate}
    replicas: 3
    template:
        metadata:
            labels: {app: my-app}
        spec:
            restartPolicy: Always

            # prefer one per node
            affinity:
                podAntiAffinity:
                  preferredDuringSchedulingIgnoredDuringExecution:
                    - labelSelector:
                        matchExpressions:
                          - {key: app, operator: In, values: [my-app]}
                      topologyKey: kubernetes.io/hostname

            containers:
              - name: my-app
                imagePullPolicy: Always
                image: nginx

                # pod environment
                volumeMounts:
                  - {name: secret-files, mountPath: "/my-app/secret/", readOnly: true}
                  - {name: config-files, mountPath: "/my-app/config/", readOnly: true}
                  - {name: data, mountPath: "/my-app/data/", readOnly: false}
                ports:
                  - {name: http, containerPort: 80, hostPort: 80}
                resources:
                    requests: {memory: "32Mi", cpu: "200m"}
                    limits: {memory: "1024Mi", cpu: "750m"}
                envFrom:
                  - secretRef: {name: my-app-secret}
                  - configMapRef: {name: my-app-config}
                env:
                  - {name: SECRET_ENV, valueFrom: {secretKeyRef: {name: my-app-secret, key: SECRET_ENV}}}
                  - {name: CONFIG_ENV, valueFrom: {configMapKeyRef: {name: my-app-config, key: CONFIG_ENV}}}
                  - {name: ENV_NAME, value: ENV_VALUE}

                # pod control
                readinessProbe:
                    httpGet:  # do a http request
                        httpHeaders: [{name: Host, value: my-app.my-domain.com}]
                        path: /my-path/
                        port: http
                        scheme: HTTP
                    tcpSocket:  # do a tcp socket probe
                        port: http
                    exec:  # run a command
                        command: [cat /tmp/healthy]
                    # probe settings
                    initialDelaySeconds: 5
                    periodSeconds: 5
                    timeoutSeconds: 4
                    successThreshold: 2
                    failureThreshold: 5

                livenessProbe:
                    httpGet:  # do a http request
                        httpHeaders: [{name: Host, value: my-app.my-domain.com}]
                        path: /my-path/
                        port: http
                        scheme: HTTP
                    tcpSocket:  # do a tcp socket probe
                        port: http
                    exec:  # run a command
                        command: [cat /tmp/healthy]
                    # probe settings
                    initialDelaySeconds: 5
                    periodSeconds: 5
                    timeoutSeconds: 4
                    successThreshold: 2
                    failureThreshold: 5

            volumes:
              - name: secret-files
                secret:
                    secretName: my-app-secret
                    items:
                      - {key: secret.json, path: secret.json}
              - name: config-files
                configMap:
                    name: my-app-config
                    items:
                      - {key: config.json, path: config.json}
              - name: data
                emptyDir: {}
---
```