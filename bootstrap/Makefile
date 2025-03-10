.POSIX:

export KUBECONFIG = $(shell pwd)/../metal/kubeconfig.yaml

.PHONY: bootstrap kustomize
default: bootstrap kustomize

bootstrap:
	ansible-playbook \
		bootstrap.yml

kustomize:
	kubectl apply -k kustomize
