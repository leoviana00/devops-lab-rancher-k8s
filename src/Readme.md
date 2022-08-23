## Balanceador EXTERNO
- Subir um HAPROXY

## VMs
- Criar as VM com vagrant e virtual box

## Cluster K8S
- Subir um Cluster K8S com o kubespray
- https://kubernetes.io/docs/setup/production-environment/tools/kubespray/

## Configurar KUBCTL

```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

## Instalação do HELM

```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

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

## Password RANCHER

- kubectl get secret --namespace cattle-system bootstrap-secret -o go-template='{{.data.bootstrapPassword|base64decode}}{{"\n"}}'
- password: hWvw0g90RGpud6nT


## Instalação do Haproxy Ingress Controller

```bash
kubectl apply -f https://raw.githubusercontent.com/haproxytech/kubernetes-ingress/v1.8/deploy/haproxy-ingress.yaml
```

## Operadores de Backup

```bash
helm repo add rancher-charts https://charts.rancher.io
helm repo update
helm install rancher-backup-crd rancher-charts/rancher-backup-crd -n cattle-resources-system --create-namespace
helm install rancher-backup rancher-charts/rancher-backup -n cattle-resources-system
```

- UNINSTALLATION

```bash
helm uninstall -n cattle-resources-system rancher-backup
helm uninstall -n cattle-resources-system rancher-backup-crd
kubectl delete namespace cattle-resources-system
```
- VerificaÇÃO DOS LOGS
```bash
kubectl logs -n cattle-system -l app.kubernetes.io/name=rancher-backup -f
```

- https://github.com/rancher/backup-restore-operator

## Basic SSL config 
- https://rancher.com/docs/rancher/v1.5/en/installing-rancher/installing-server/basic-ssl-config/

## Criar certificado

cat lab.k8s.rancher.crt.pem lab.k8s.rancher.key.pem > rancher.pem