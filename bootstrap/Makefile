.POSIX:

export KUBECONFIG = $(shell pwd)/../metal/kubeconfig.yaml

.PHONY: kustomize bootstrap

default: kustomize bootstrap

kustomize:
	kubectl apply -k kustomize

bootstrap:
	ansible-playbook \
		bootstrap.yml
