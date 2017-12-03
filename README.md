# tf-docker-swarm
Create a docker swarm cluster with terraform

## Usage
```
export TF_VAR_do_token=<do token>
export TF_VAR_ssh_fingerprint=<ssh fingerprint of public key>
export TF_VAR_ssh_private_key=<path to your private ssh key>

terraform plan

terraform apply
```