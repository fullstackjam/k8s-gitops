# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build and Deploy Commands

### Full Deployment Pipeline
```bash
make                    # Runs: bootstrap external smoke-test post-install applications
```

### Individual Components
```bash
make metal              # Bare metal provisioning (PXE boot, prerequisites, kubespray, cilium)
make bootstrap          # Bootstrap ArgoCD on the cluster (ansible-playbook kubernetes/bootstrap.yml)
make external           # Apply Terraform for Cloudflare tunnel/DNS (cd external && terraform apply)
make applications       # Deploy standalone ArgoCD applications (kubectl apply -f applications/)
```

### Testing
```bash
make test               # Run all Go integration tests (gotestsum)
make smoke-test         # Run smoke tests only (filter=Smoke)
cd test && make filter=TestSmoke  # Run specific test
```

### Development Environment
```bash
make tools              # Launch Nix devShell with all required tools in Docker
nix develop             # Direct Nix shell (requires Nix with flakes)
```

### Metal/Bare Metal Commands
```bash
cd metal && make boot           # PXE boot nodes
cd metal && make prerequisites  # Install prerequisites on nodes
cd metal && make k8s           # Deploy Kubernetes via kubespray
cd metal && make cilium        # Install Cilium CNI
```

### External/Terraform Commands
```bash
cd external && make plan    # Terraform plan
cd external && make apply   # Terraform apply (Cloudflare resources)
```

### Helper Scripts
```bash
./scripts/argocd-admin-password    # Get ArgoCD admin password
./scripts/gitea-admin-password     # Get Gitea admin password
./scripts/grafana-admin-password   # Get Grafana admin password
./scripts/kanidm-reset-password    # Reset Kanidm password
```

## Architecture Overview

### GitOps Deployment Model
- **ArgoCD** is the central deployment controller, bootstrapped via Ansible (`kubernetes/bootstrap.yml`)
- A single **ApplicationSet** in `kubernetes/system/argocd/values.yaml` auto-discovers and deploys all charts from:
  - `kubernetes/system/*` - Core infrastructure (argocd, cert-manager, ingress-nginx, monitoring, rook-ceph, etc.)
  - `kubernetes/platform/*` - Platform services (gitea, grafana, harbor, kanidm, woodpecker, etc.)
  - `kubernetes/apps/*` - User applications
- **Standalone applications** in `applications/` directory are deployed separately with custom configurations

### Directory Structure Conventions
- Each service is a Helm chart wrapper in its directory with `Chart.yaml` and `values.yaml`
- Charts typically wrap upstream Helm charts as dependencies
- Custom templates go in `templates/` subdirectory when needed
- Namespace matches the directory basename by default (ArgoCD convention)

### Infrastructure Layers
1. **Metal Layer** (`metal/`): Ansible playbooks for bare metal provisioning via PXE
2. **Kubernetes Layer**: Deployed via external kubespray repository (submodule reference)
3. **External Layer** (`external/`): Terraform modules for Cloudflare tunnel, DNS, and secrets
4. **Platform Layer** (`kubernetes/`): All Kubernetes workloads managed by ArgoCD

### Key Integrations
- **Cloudflare Tunnel**: External access via `cloudflared` in `kubernetes/system/cloudflared/`
- **External DNS**: Automatic DNS record management with Cloudflare
- **cert-manager**: Let's Encrypt certificates via `letsencrypt-prod` ClusterIssuer
- **External Secrets Operator**: Secret management in `kubernetes/platform/external-secrets/`

### Kubeconfig Location
The kubeconfig is at `metal/kubeconfig.yaml` - all Makefiles reference this path.

## Testing Architecture

Tests are in `test/` directory using Go with Terratest:
- `smoke_test.go` - Verifies main services (argocd, gitea, grafana, kanidm, zot) are accessible
- `integration_test.go` - Full integration tests
- `external_test.go` - External access tests
- Tests use `gotestsum` for better output formatting
