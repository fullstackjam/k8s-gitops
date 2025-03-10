.POSIX:

export KUBECONFIG = $(shell pwd)/../kubeconfig.yaml

.PHONY: bootstrap
bootstrap:
	ansible-playbook \
		bootstrap.yml
