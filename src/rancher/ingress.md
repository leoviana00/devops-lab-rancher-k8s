<h1 align="center">Ingress</h1>

## Ingress File

```bash
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: rancher-ingress
  namespace: cattle-system
  annotations:
    # haproxy.org/path-rewrite: "/"
    # kubernetes.io/ingress.class: "haproxy"
    cert-manager.io/cluster-issuer: "letsencrypt-staging"
spec:
  tls:
    - hosts:
        - lab.k8s.rancher
      secretName: tls-rancher-ingress
  rules:
    - host: lab.k8s.rancher
      http:
        paths:
        - path: /
          pathType: Prefix
          backend:
            service:
              name: rancher
              port:
                number: 80
```