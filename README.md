# Argo infra personal labs

## Infra applications

Available Applications:

| Applications  | DNS | Username  | Password | Links |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Nginx-ingress | | | | <https://kubernetes.github.io/ingress-nginx> |
| ArgoCD |  <http://rabbitmq.local.com.br> | admin  | get password at k3s start script | <https://argo-cd.readthedocs.io/en/stable>  |
| Keycloak | <http://identity.local.com.br/admin/master/console>  | admin  | password |  <https://www.keycloak.org>  |
| RabbitMQ  | <http://rabbitmq.local.com.br>  | user  | bitnami | <https://www.rabbitmq.com>  |
| CertManager | | | | <https://cert-manager.io/> |
| External Secret Operator | | | | <https://external-secrets.io/latest> |
| Redpanda/console | <http://redpanda.local.com.br> | admin | password | <https://redpanda.com> |
| Kafka/console | <http://kafka.local.com.br> | admin | password | <https://kafka.apache.org/> |

## ArgoCD Folders organization

### Base

- **base/applications-infra**: Contains k8s infra applications

### Overlay

Environments folders that inherit from base folder. It uses [kustomize](https://github.com/kubernetes-sigs/kustomize to allow environment based customization.
