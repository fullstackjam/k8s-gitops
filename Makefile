.POSIX:
.PHONY: *
.EXPORT_ALL_VARIABLES:

KUBECONFIG = $(shell pwd)/metal/kubeconfig.yaml
KUBE_CONFIG_PATH = $(KUBECONFIG)

default: bootstrap terraform smoke-test post-install

metal:
	make -C metal

bootstrap:
	ansible-playbook kubernetes/bootstrap.yml

terraform:
	make -C terraform

smoke-test:
	make -C test filter=Smoke

post-install:
	@./scripts/hacks

test:
	make -C test

tools:
	@docker run \
		--rm \
		--interactive \
		--tty \
		--network host \
		--env "KUBECONFIG=${KUBECONFIG}" \
		--volume "/var/run/docker.sock:/var/run/docker.sock" \
		--volume $(shell pwd):$(shell pwd) \
		--volume ${HOME}/.ssh:/root/.ssh \
		--volume ${HOME}/.terraform.d:/root/.terraform.d \
		--volume homelab-tools-cache:/root/.cache \
		--volume homelab-tools-nix:/nix \
		--workdir $(shell pwd) \
		--group-add nixbld \
		nixos/nix nix --experimental-features 'nix-command flakes' develop
