# Argo infra personal labs

## Infra applications

Available Applications:

| Applications  | DNS | Username  | Password | Links | Comments |
| ------------- | ------------- | ------------- | ------------- | ------------- | | ------------- |
| Ingress-nginx | | | | <https://kubernetes.github.io/ingress-nginx> | |
| ArgoCD |  <http://argo.local.com.br> | admin  | get password at k3s start script | <https://argo-cd.readthedocs.io/en/stable>  | |
| Keycloak | <http://identity.local.com.br/admin/master/console>  | admin  | password |  <https://www.keycloak.org>  | To activate metrics realmsSettings/events/metrics-listener |
| RabbitMQ  | <http://rabbitmq.local.com.br>  | admin  | password | <https://www.rabbitmq.com>  | |
| CertManager | | | | <https://cert-manager.io/> | |
| External Secret Operator | | | | <https://external-secrets.io/latest> | |
| Redpanda |redpanda-0.redpanda.redpanda.svc.cluster.local.:9093 | admin | password | <https://redpanda.com> | |
| Redpanda/console | <http://redpanda.local.com.br> | admin | password | <https://redpanda.com/redpanda-console-kafka-ui> | |
| Kafka | kafka-controller-0.kafka-controller-headless.kafka.svc.cluster.local.:9092 | admin | password | <https://kafka.apache.org/> | |
| Kafka/console | <http://kafka.local.com.br> | <admin@conduktor.io> | password | <https://www.conduktor.io/console/> | |

## ArgoCD Folders organization

### Base

- **base/applications-infra**: Contains k8s infra applications

### Overlay

Environments folders that inherit from base folder. It uses [kustomize](https://github.com/kubernetes-sigs/kustomize) to allow environment based customization.
