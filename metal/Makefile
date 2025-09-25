.POSIX:

env ?= prod
export KUBECONFIG = $(shell pwd)/kubeconfig.yaml

default: boot prerequisites kubespray cilium clean

boot:
	ansible-playbook \
		--inventory inventories/${env}.yml \
		boot.yml

prerequisites:
	ansible-playbook \
		--inventory inventories/${env}.yml \
		prerequisites.yml

kubespray:
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
