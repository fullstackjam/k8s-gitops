# Post-installation

## Backup secrets

Save the following files to a safe location like a password manager:

- `~/.ssh/id_rsa`
- `~/.ssh/id_rsa.pub`
- `./metal/kubeconfig.yaml`
- `~/.external.d/credentials.tfrc.json`
- `./external/external.tfvars`

## Admin credentials

- ArgoCD:
    - Username: `admin`
    - Password: run `./scripts/argocd-admin-password`
- Gitea:
    - Username: `gitea_admin`
    - Password: run `./scripts/gitea-admin-password`
- Kanidm:
    - Usernames: `idm_admin`
    - Password: run `./scripts/kanidm-reset-password idm_admin`
    - Login Command: `kanidm login --url "https://auth.fullstackjam.com" --name idm_admin`
- Grafana:
    - Usernames: `admin`
    - Password: run `./scripts/grafana-reset-password idm_admin`
- Other apps:
    - Username: `admin`
    - Password: get from `global-secrets` namespace

## Run the full test suite

After the homelab has been stabilized, you can run the full test suite to ensure that everything is working properly:

```sh
make test
```

!!! info

    The "full" test suite is still in its early stages, so any contribution is greatly appreciated.
