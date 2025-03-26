.POSIX:

env ?= prod
export KUBECONFIG = $(shell pwd)/kubeconfig.yaml

default: boot k3s cilium

boot:
	ansible-playbook \
		--inventory inventories/${env}.yml \
		boot.yml

k3s:
	ansible-playbook \
		--inventory inventories/${env}.yml \
		k3s.yml

console:
	ansible-console \
		--inventory inventories/${env}.yml
