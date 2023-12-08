# ArgoCD Infra labs

## Apps

| Applications  | DNS | Username  | Password | Links | Comments |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| Ingress-nginx | | | | <https://kubernetes.github.io/ingress-nginx> | |
| ArgoCD |  <http://argo-local.cloud-diplomats.com> | admin  | get password at init script | <https://argo-cd.readthedocs.io/en/stable>  | |
| Keycloak | <http://identity-local.cloud-diplomats.com/admin/master/console>  | admin  | password |  <https://www.keycloak.org>  | To activate metrics realmsSettings/events/metrics-listener |
| RabbitMQ  | <http://rabbitmq-local.cloud-diplomats.com>  | admin  | password | <https://www.rabbitmq.com>  | |
| CertManager | | | | <https://cert-manager.io/> | |
| External Secret Operator | | | | <https://external-secrets.io/latest> | |
| External DNS | | | | <https://kubernetes-sigs.github.io/external-dns/v0.13.6/> | |

## Folders organization

### Applications

#### applications/base

- **base/shared-app**: Infra shared configurations.

#### applications/overlay

Environments folders that inherit from base folder. It uses [kustomize](https://github.com/kubernetes-sigs/kustomize) to allow environment based customization.

### ArgoCD Applications

#### argo-app/base

- **base**: ArgoCD Applications

#### argo-app/overlay

Environments folders that inherit from base folder. It uses [kustomize](https://github.com/kubernetes-sigs/kustomize) to allow environment based customization.
