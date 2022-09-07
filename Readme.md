<h1 align="center">DevOps - Rancher e Kubernetes</h1>

<p align="center">
  <img alt="Rancher" src="https://img.shields.io/static/v1?label=K8S&message=RANCHER&color=8257E5&labelColor=000000"  />
  <img alt="License" src="https://img.shields.io/static/v1?label=license&message=MIT&color=49AA26&labelColor=000000">
</p>

<p align="center">
  <a href="#-projeto">Projeto</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-tecnologias">Tecnologias</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#%EF%B8%8F-ambiente">Ambiente</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-etapas">Etapas</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-licença">Licença</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-referências">Referências</a>
</p>

<p align="center">
  <img alt="Rancher" src="images/k8s-rancher.png">
</p>

## 🌱 Projeto

- Estudo `Rancher` e `Kubernetes`. 

## ✨ Tecnologias

- Vagrant
- Ansible
- Kubspray
- Kubernetes
- Docker
- Haproxy
- Haproxy Ingress Controller
- Rancher
- Virtualbox
- Cert-manager

## 🚀 Etapas

0. [Subir um balanceador dockerizado localmente.](/src/balanceador/Readme.md) 
1. [Criar as Vm's.](/src/vagrant/Readme.md)
2. [Subir um cluster kubernetes.](/src/kubespray/kubespray.md)
3. [Instalar o Helm.](/src/helm/helm.md)
4. [Deployar o Cert-manager.](/src/rancher/cert-manager.md)
5. [Criar um emissor.](/src/rancher/cluster-issue.md)
6. [Deployar o Rancher.](/src/rancher/rancher.md)
7. [Gerar certificado.](/src/cert-manager/README.md)
8. [Configurar um Ingress.](/src/rancher/ingress.md)

## 📄 Licença

Esse projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 🙇 Referências

- https://github.com/kubernetes-sigs/kubespray
- https://kubernetes.io/docs/setup/production-environment/tools/kubespray/
