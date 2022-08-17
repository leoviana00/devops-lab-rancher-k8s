## Declare
declare -a IPS=(192.168.50.30 192.168.50.11 192.168.50.12 192.168.50.20 192.168.50.41)

ansible-playbook -i inventory/lab-k8s/hosts.yaml  --become --become-user=vagrant cluster.yml
