# Argo infra personal labs

## Infra applications

Available Applications:

| Applications  | Urls | Username  | Password |
| ------------- | ------------- | ------------- | ------------- |
| [Nginx-ingress](https://kubernetes.github.io/ingress-nginx) | | | |
| [ArgoCD](https://argo-cd.readthedocs.io/en/stable)  | <http://argo.local.com.br>  | admin  | get password at k3s start script |
| [Keycloak](https://www.keycloak.org)  | <http://identity.local.com.br/admin/master/console>  | admin  | password |
| [RabbitMQ](https://www.rabbitmq.com)  | <http://rabbitmq.local.com.br>  | user  | bitnami |
| [CertManager](https://www.rabbitmq.com) | | | |
| [External Secret Operator](https://external-secrets.io/latest) | | | |
| [Redpanda](https://redpanda.com) | <http://redpanda.local.com.br> | admin | password |
| [Strimzi](https://strimzi.io/) | | admin | password |

## ArgoCD Folders organization

### Base

- **base/applications-infra**: Contains k8s infra applications

### Overlay

Environments folders that inherit from base folder. It uses [kustomize](https://github.com/kubernetes-sigs/kustomize) to allow environment based customization.
