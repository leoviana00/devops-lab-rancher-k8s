## Balanceador EXTERNO
- Subir um HAPROXY

## VMs
- Criar as VM com vagrant e virtual box

## Cluster K8S
- Subir um Cluster K8S com o kubespray

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


## Instalação do Haproxy Ingress Controller

```bash
kubectl apply -f https://raw.githubusercontent.com/haproxytech/kubernetes-ingress/v1.8/deploy/haproxy-ingress.yaml
```

