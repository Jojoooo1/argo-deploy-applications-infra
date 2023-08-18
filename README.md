# Argo infra personal labs

## Infra applications

Available Applications:

- keycloak: <http://identity.local.com.br/admin/master/console>
  - username: 'admin', password: 'password'
- rabbitmq: <http://rabbitmq.local.com.br>
  - username: 'user', password: 'bitnami'

## ArgoCD Folders organization

### Base

- **base/applications-infra**: Contains k8s infra applications

### Overlay

Environments folders that inherit from base folder. It uses [kustomize](https://github.com/kubernetes-sigs/kustomize) to allow environment based customization.
