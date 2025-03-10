# Roadmap

!!! info

    Current status: **ALPHA**

## Alpha requirements

Literally anything that works.

## Beta requirements

Good enough for tinkering and personal usage, and reasonably secure.

- [x] Automated bare metal provisioning
    - [x] Controller set up (Docker)
    - [x] OS installation (PXE boot)
- [x] Automated cluster creation (k3s)
- [x] Automated application deployment (ArgoCD)
- [x] Automated DNS management
- [x] Initialize GitOps repository on Gitea automatically
- [x] Observability
    - [x] Monitoring
    - [x] Logging
    - [x] Alerting
- [x] SSO
- [ ] Reasonably secure
    - [x] Automated certificate management
    - [x] Declarative secret management
    - [ ] Replace all default passwords with randomly generated ones
    - [x] Expose services to the internet securely with Cloudflare Tunnel
- [x] Only use open-source technologies (except external managed services in `./external`)
- [x] Everything is defined as code
- [ ] Backup solution (3 copies, 2 seperate devices, 1 offsite)
- [ ] Define [SLOs](https://en.wikipedia.org/wiki/Service-level_objective):
    - [ ] 70% availability (might break in the weekend due to new experimentation)
- [x] Core applications
    - [x] Gitea
    - [x] Woodpecker
    - [x] Private container registry

## Stable requirements

Can be used in "production" (for family or even small scale businesses).

- [ ] Complete documentation
    - [x] Diagram as code
    - [x] Book (this book)
    - [ ] Walkthrough tutorial and feature demo (video)
- [x] Configuration script for new users
- [ ] More dashboards and alert rules
- [ ] SLOs:
    - [ ] 99,9% availability (less than 9 hours of downtime per year)
    - [ ] 99,99% data durability
- [ ] Clear upgrade path
