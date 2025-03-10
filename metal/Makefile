.POSIX:

env ?= prod
export KUBECONFIG = $(shell pwd)/kubeconfig.yaml

default: helm-diff-check cluster

helm-diff-check:
	@helm plugin list | grep -q diff || helm plugin install https://github.com/databus23/helm-diff
	
cluster:
	ansible-playbook \
		--inventory inventories/${env}.yml \
		cluster.yml

console:
	ansible-console \
		--inventory inventories/${env}.yml
