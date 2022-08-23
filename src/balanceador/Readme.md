<h1 align="center">Balanceador - Haproxy</h1>

<p align="center">
  <img alt="Haproxy" src="../../images/haproxy.png">
</p>

## Docker Compose File

```docker-compose
haproxy:
    image: haproxy:1.8
    volumes:
        - ./haproxy:/haproxy-override
        - ./haproxy/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro
        - ./haproxy/rancher.pem:/usr/local/etc/haproxy/rancher.pem
    ports:
        - "80:80"
        - "81:81"
        - "441:441"
        - "6443:6443"
        - "443:443"
```

- Mapeamento para o diretório haproxy contendo aruivo de configuração `haproxy.cfg`;
- Criação de um certificado para colococar nesse diretório haproxy;
- Inicialização do container:

- `haproxy.cfg`

```bash
global
  log /dev/log  local0
  log /dev/log  local1 notice
  chroot /var/lib/haproxy
  user haproxy
  group haproxy
  daemon

defaults
  log    global
  timeout connect 5000
  timeout client  50000
  timeout server  50000

listen  stats
  mode http
  bind *:81
  stats enable
  stats hide-version
  stats refresh 30s
  stats show-node
  stats auth admin:dev123
  stats uri  /stats
  stats show-desc Praticando Haproxy

# -------------------------------
#         KUBERNETES
# -------------------------------
listen kubernetes-apiserver-https
  bind *:6443
  mode tcp
  option log-health-checks
  timeout client 3h
  timeout server 3h
  balance roundrobin
  server k8s_m01 192.168.50.11:6443 check check-ssl verify none inter 2000

# -------------------------------
#             RANCHER 
# -------------------------------
listen rancher
  bind *:443 ssl crt /usr/local/etc/haproxy/rancher.pem
  mode tcp
  reqadd X-Forwarded-Proto:\ https
  server WS1-RANCHER 192.168.50.41:31292 check ssl verify none
```

```bash
docker-compose up -d
```