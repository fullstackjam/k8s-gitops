.POSIX:

env ?= prod
export KUBECONFIG = $(shell pwd)/kubeconfig.yaml

default: boot prerequisites k8s cilium clean

boot:
	ansible-playbook \
		--inventory inventories/${env}.yml \
		boot.yml

prerequisites:
	ansible-playbook \
		--inventory inventories/${env}.yml \
		prerequisites.yml

k8s:
	ansible-playbook \
		--inventory inventories/${env}.yml \
		kubespray.yml

cilium:
	ansible-playbook \
		--inventory inventories/${env}.yml \
		cilium.yml

console:
	ansible-console \
		--inventory inventories/${env}.yml

clean:
	docker compose --project-directory ./roles/pxe_server/files down
