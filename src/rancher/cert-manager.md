## CERT MANAGER

```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.7.1/cert-manager.crds.yaml
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.7.1
```

- https://rancher.com/docs/rancher/v2.5/en/installation/install-rancher-on-k8s/#1-add-the-helm-chart-repository