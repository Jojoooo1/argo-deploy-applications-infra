# /bin/bash

NGINX_INGRESS_IP=$(kubectl get service ingress-nginx-controller -n ingress-nginx -ojson | jq -r '.status.loadBalancer.ingress[].ip')

echo "NGINX_INGRESS_IP=$NGINX_INGRESS_IP"

echo ">>> adding INGRESS_IP in /etc/hosts for dns:"
echo "$NGINX_INGRESS_IP argo-local.jonathan.com.br" | sudo tee -a /etc/hosts
