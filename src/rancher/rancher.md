## RANCHER
- Instalar o RANCHER

## Instalação do RANCHER

```bash

helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
kubectl create namespace cattle-system
helm repo update

helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=lab.k8s.rancher \
  --set replicas=2
```

- https://rancher.com/docs/rancher/v2.5/en/installation/install-rancher-on-k8s/#1-add-the-helm-chart-repository

## Let’s Encrypt Certificates

- https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nginx-ingress-with-cert-manager-on-digitalocean-kubernetes-pt
- https://stackoverflow.com/questions/58936695/how-to-deploy-a-letsencryp-with-cert-manager-and-haproxy-ingress
- https://www.haproxy.com/blog/enable-tls-with-lets-encrypt-and-the-haproxy-kubernetes-ingress-controller/
