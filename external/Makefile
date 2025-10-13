.POSIX:
.EXPORT_ALL_VARIABLES:

KUBECONFIG = $(shell pwd)/../metal/kubeconfig.yaml
KUBE_CONFIG_PATH = $(KUBECONFIG)

default: apply

~/.terraform.d/credentials.tfrc.json:
	terraform login

terraform.tfvars:
	cp terraform.tfvars.example ${@}
	nvim ${@}

.terraform.lock.hcl: ~/.terraform.d/credentials.tfrc.json versions.tf terraform.tfvars
	terraform init
	touch ${@}

namespaces:
	ansible-playbook namespaces.yml

plan: .terraform.lock.hcl
	terraform plan

apply: .terraform.lock.hcl namespaces
	terraform apply -auto-approve
