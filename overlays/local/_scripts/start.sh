#!/bin/bash

DIR="$(cd "$(dirname "$0")" && pwd)"
APP_INFRA_DIR="$DIR/../../../base/applications-infra"
ARGO_CHART_VERSION="5.43.4"

message() {
  echo -e "\n######################################################################"
  echo "# $1"
  echo "######################################################################"
}

[[ ! -x "$(command -v kubectl)" ]] && echo "kubectl not found, you need to install kubectl" && exit 1
[[ ! -x "$(command -v helm)" ]] && echo "helm not found, you need to install helm" && exit 1
[[ ! -x "$(command -v kustomize)" ]] && echo "kustomize not found, you need to install kustomize" && exit 1
[[ ! -x "$(command -v argocd)" ]] && echo "argocd not found, you need to install argocd-cli" && exit 1

installK3s() {
  [[ -f /usr/local/bin/k3s-uninstall.sh ]] && /usr/local/bin/k3s-uninstall.sh
  # export K3S_CONFIG_FILE="$DIR/install/k3s/k3s-config.yaml"
  curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION="v1.27.4+k3s1" INSTALL_K3S_EXEC="server --write-kubeconfig ~/.kube/k3s-config --write-kubeconfig-mode 666 --disable traefik" sh
  export KUBECONFIG=~/.kube/k3s-config
}

installArgoCD() {
  message ">>> deploying ArgoCD"

  local ARGO_DIR="$DIR/install/argo"

  # Install chart
  helm repo add argo https://argoproj.github.io/argo-helm
  helm repo update
  helm uninstall argocd
  helm install argocd argo/argo-cd --create-namespace --namespace=argocd --version $ARGO_CHART_VERSION \
    --set applicationSet.enabled=false \
    --set notifications.enabled=false \
    --set dex.enabled=false \
    --set configs.cm."kustomize\.buildOptions"="--load-restrictor LoadRestrictionsNone" \
    --set configs.cm."timeout\.reconciliation"="10s"

  # Deploy secret for ArgoCD
  kubectl -n argocd rollout status deployment/argocd-server

  # Install ArgoCD applications
  kubectl apply -f $APP_INFRA_DIR/argocd-helm.yaml
  kubectl apply -f $ARGO_DIR/parent.yaml
}

syncArgoCDApplications() {
  password=$1
  message ">>> Awaiting ArgoCD applications to sync..."
  until argocd login --core --username admin --password $password --insecure; do :; done
  kubectl config set-context --current --namespace=argocd
  until argocd app sync argocd; do echo "awaiting argocd to be sync..." && sleep 10; done
  until argocd app sync parent-applications; do echo "awaiting parent-applications to be sync..." && sleep 10; done
}

deployNginxIngress() {
  message ">>> Deploying nginx-ingress"
  until argocd app sync ingress-nginx; do echo "awaiting ingress-nginx to be deployed..." && sleep 20; done

  export NGINX_INGRESS_IP=$(kubectl get service ingress-nginx-controller -n ingress-nginx -ojson | jq -r '.status.loadBalancer.ingress[].ip')
  echo "NGINX_INGRESS_IP=$NGINX_INGRESS_IP"
}

addUrlToHost() {
  host=$1
  if ! grep -q $host "/etc/hosts"; then
    echo "$NGINX_INGRESS_IP $host" | sudo tee -a /etc/hosts
  fi
}

installK3s
installArgoCD
ARGOCD_PWD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
syncArgoCDApplications $ARGOCD_PWD
deployNginxIngress

addUrlToHost "argo-local.jonathan.com.br"
addUrlToHost "identity-local.jonathan.com.br"
addUrlToHost "rabbitmq-local.jonathan.com.br"
addUrlToHost "grafana-local.jonathan.com.br"
addUrlToHost "prometheus-local.jonathan.com.br"
addUrlToHost "alertmanager-local.jonathan.com.br"

echo ">>> argo: http://argo-local.jonathan.com.br - username: 'admin', password: '$ARGOCD_PWD'"
echo ">>> keycloak: http://identity-local.jonathan.com.br/admin/master/console/ - username: 'admin', password: 'password'"
echo ">>> rabbitmq: http://rabbitmq-local.jonathan.com.br - username: 'user', password: 'bitnami'"
echo ">>> grafana: http://grafana-local.jonathan.com.br - username: 'user', password: 'password'"
echo ">>> prometheus: http://prometheus-local.jonathan.com.br"
echo ">>> alertmanager: http://alertmanager-local.jonathan.com.br"
