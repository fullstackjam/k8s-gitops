# k8s-gitops

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Documentation](https://img.shields.io/badge/docs-available-green)](docs/)
[![Status](https://img.shields.io/badge/status-alpha-orange)](https://github.com/fullstackjam/k8s-gitops)

A comprehensive, production-ready Kubernetes homelab infrastructure built with Infrastructure as Code (IaC) and GitOps practices. This repository provides a complete solution for deploying and managing a self-hosted Kubernetes cluster with modern DevOps tools and best practices.

## 🚀 Features

### Core Infrastructure
- **Automated Bare Metal Provisioning**: PXE-based installation of Fedora Server across multiple nodes
- **Kubernetes Cluster**: Deployed using kubespray for production-grade configuration
- **GitOps Workflow**: ArgoCD for continuous deployment and configuration management
- **Infrastructure as Code**: Everything defined declaratively with Ansible, Terraform, and Kubernetes manifests

### Platform Services
- **Container Registry**: Private container registry with Harbor
- **CI/CD Pipeline**: Woodpecker CI for automated builds and deployments
- **Git Repository**: Self-hosted Gitea for source code management
- **Identity Management**: Kanidm for authentication and authorization
- **Monitoring Stack**: Grafana, Prometheus, and Loki for observability
- **Certificate Management**: Automated SSL/TLS certificates with cert-manager and Let's Encrypt

### Storage & Networking
- **Distributed Storage**: Rook Ceph for reliable block and object storage
- **Load Balancing**: NGINX Ingress Controller for traffic routing
- **DNS Management**: External DNS integration with Cloudflare
- **Secure Tunneling**: Cloudflare Tunnel for secure external access

### Security & Backup
- **Secret Management**: External Secrets Operator with encrypted storage
- **Network Policies**: Cilium for network security and observability
- **Automated Updates**: Renovate for dependency management
- **Backup Solutions**: Automated backup strategies for data protection

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Hardware Layer                           │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐        │
│  │ Node 1  │  │ Node 2  │  │ Node 3  │  │ Node N  │        │
│  │(Master) │  │(Worker) │  │(Worker) │  │(Worker) │        │
│  └─────────┘  └─────────┘  └─────────┘  └─────────┘        │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│                 Infrastructure Layer                        │
│  Fedora Server + kubespray + Kubernetes + Rook Ceph        │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│                   Platform Services                         │
│  ArgoCD │ Gitea │ Woodpecker │ Harbor │ Kanidm │ Grafana    │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│                  Application Layer                          │
│  Homepage │ Jellyfin │ Matrix │ Paperless │ Custom Apps     │
└─────────────────────────────────────────────────────────────┘
```

## 📚 Documentation

Comprehensive documentation is available in the [`docs/`](docs/) directory, including:

- **[Installation Guide](docs/installation/)**: Step-by-step setup instructions
- **[Architecture Overview](docs/reference/architecture/)**: Detailed system architecture
- **[Concepts](docs/concepts/)**: Key concepts and design decisions
- **[How-to Guides](docs/how-to-guides/)**: Common tasks and configurations
- **[Roadmap](docs/reference/roadmap.md)**: Current status and future plans

## 🚀 Quick Start

### Prerequisites

- Linux machine with Docker installed
- Make utility
- Git
- SSH access to target servers

### Development Sandbox

For testing and development, you can run a local sandbox environment:

```bash
# Clone the repository
git clone https://github.com/fullstackjam/k8s-gitops
cd k8s-gitops

# Checkout development branch
git checkout dev

# Start the tools container
make tools

# Build the development cluster
make
```

The sandbox will be available at `https://home.127-0-0-1.nip.io` (ignore SSL warnings in development).

### Production Deployment

For production deployment, see the [Production Installation Guide](docs/installation/production/).

## 🛠️ Tech Stack

### Infrastructure
- **Operating System**: Fedora Server
- **Container Orchestration**: Kubernetes (deployed with kubespray)
- **Infrastructure Automation**: Ansible
- **Infrastructure Provisioning**: Terraform
- **GitOps**: ArgoCD

### Storage & Networking
- **Storage**: Rook Ceph
- **Load Balancer**: NGINX Ingress Controller
- **Network Security**: Cilium CNI
- **DNS**: External DNS + Cloudflare
- **Tunneling**: Cloudflare Tunnel

### Platform Services
- **Version Control**: Gitea
- **CI/CD**: Woodpecker CI
- **Container Registry**: Harbor
- **Identity Management**: Kanidm
- **Monitoring**: Grafana + Prometheus + Loki
- **Certificate Management**: cert-manager + Let's Encrypt

### Development Tools
- **Secret Management**: External Secrets Operator
- **Dependency Updates**: Renovate
- **Documentation**: MkDocs Material
- **Configuration Management**: Helm Charts

## 📁 Repository Structure

```
k8s-gitops/
├── docs/                    # Documentation
│   ├── concepts/           # Core concepts and explanations
│   ├── how-to-guides/     # Step-by-step guides
│   ├── installation/      # Installation instructions
│   └── reference/         # Technical reference
├── kubernetes/            # Kubernetes manifests
│   ├── apps/             # Application deployments
│   ├── platform/         # Platform services
│   └── system/           # System components
├── metal/                 # Bare metal provisioning (Ansible)
├── terraform/            # Infrastructure provisioning
├── scripts/              # Utility scripts
└── test/                 # Integration tests
```

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](docs/reference/contributing.md) for details.

### Development Workflow

1. Fork the repository
2. Create a feature branch from `upstream/master`
3. Make your changes
4. Test your changes with the sandbox environment
5. Submit a pull request

## 📋 Status

**Current Status**: Alpha

This project is currently in alpha phase. While functional, it's primarily designed for learning and experimentation. See our [Roadmap](docs/reference/roadmap.md) for planned features and stability improvements.

## 📄 License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

**Important**: By using this project, you agree to:
- Use the same GPL v3 license for any derived works
- Keep your project open-source
- Include proper attribution

## 🙏 Acknowledgments

- Inspired by [khuedoan/homelab](https://github.com/khuedoan/homelab)
- Built with modern DevOps tools and practices
- Community contributions and feedback

## 📞 Support

- 📖 **Documentation**: [`docs/`](docs/) directory
- 🐛 **Bug Reports**: [GitHub Issues](https://github.com/fullstackjam/k8s-gitops/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/fullstackjam/k8s-gitops/discussions)
- 📧 **Contact**: mail@fullstackjam.com

---

**⭐ If you find this project helpful, please give it a star!**
