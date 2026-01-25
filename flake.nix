{
  description = "Homelab";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        # TODO remove unfree after removing Terraform
        # (Source: https://xeiaso.net/blog/notes/nix-flakes-terraform-unfree-fix)
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      with pkgs;
      {
        devShells.default = mkShell {
          packages = [
            ansible
            ansible-lint
            diffutils
            docker
            docker-compose
            git
            go
            gotestsum
            jq
            k9s
            kanidm
            kubectl
            kubernetes-helm
            kustomize
            libisoburn
            openssh
            pre-commit
            shellcheck
            terraform # TODO replace with OpenTofu, Terraform is no longer FOSS
            yamllint

            (python3.withPackages (p: with p; [
              jinja2
              kubernetes
              netaddr
              pexpect
              rich
            ]))
          ];
        };
      }
    );
}
