.POSIX:

env ?= prod
export KUBECONFIG = $(shell pwd)/kubeconfig.yaml

default: boot k3s cilium clean

boot:
	ansible-playbook \
		--inventory inventories/${env}.yml \
		boot.yml

k3s:
	ansible-playbook \
		--inventory inventories/${env}.yml \
		k3s.yml

cilium:
	ansible-playbook \
		--inventory inventories/${env}.yml \
		cilium.yml

console:
	ansible-console \
		--inventory inventories/${env}.yml

clean:
	docker compose --project-directory ./roles/pxe_server/files down
