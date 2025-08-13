# Ansible Hub - Self-Hosted Infrastructure Automation

A collection of Ansible playbooks and roles for deploying self-hosted services with a focus on easy setup and maintenance.

## 🎯 Overview

This repository provides production-ready Ansible automation for deploying modern self-hosted services. The main focus is on Matrix homeserver deployment with Jitsi integration, plus essential infrastructure components.

## 🚀 Featured Deployments

### Matrix + Jitsi Communication Stack
- **Full Matrix homeserver** with Element web client
- **Jitsi video conferencing** integration
- **Docker-based** containerized deployment
- **Source**: [matrix-docker-ansible-deploy](https://github.com/spantaleev/matrix-docker-ansible-deploy) (maintained as git subtree)

### Infrastructure Components
- **Docker installation** with Iran-optimized mirrors
- **Traefik reverse proxy** with automatic SSL/TLS
- **Portainer** container management (optional)
- **MinIO** object storage
- **Observability stack** (monitoring and logging)

## 📁 Repository Structure

```
├── matrix/                    # Matrix homeserver deployment
├── roles/                     # Custom Ansible roles
│   ├── geerlingguy.docker/   # Docker installation
│   └── traefik/              # Reverse proxy with SSL
├── group_vars/               # Host group configurations
├── host_vars/                # Individual host settings
├── bin/                      # Utility scripts
├── templates/                # Configuration templates
└── *.yml                     # Main playbooks
```

## 🇮🇷 Iran-Specific Optimizations

- **Docker registry mirrors** for reliable container pulls
- **Network-optimized** package repositories
- **SSL certificate** handling with Let's Encrypt for Traefik with ArvanCloud as DNS provider.
- **Proxy-aware** configurations where needed

## 🛠️ Quick Start

### Prerequisites
- Ansible 2.9+ on your local machine
- Ubuntu/Debian target server with root access
- Domain name with DNS control

### 1. Initial Server Setup
```bash
# run:
./bin/init-ansible-host.sh ubuntu@targethost.com
```

### 2. Docker Installation
```bash
# For Iranian servers with mirror support
ansible-playbook -i inventory.yml docker-install.yml

# Enable Portainer (optional)
# Set portainer_enabled: true in group_vars/docker_servers.yml
```

### 3. Deploy Matrix Communication Stack
```bash
# See matrix/README.md for detailed instructions
cd matrix/matrix-docker-ansible-deploy
# Configure inventory and variables
just roles
# or
ansible-playbook -i inventory/hosts setup.yml --tags=install-all,ensure-matrix-users-created,start
```

### 4. Setup Reverse Proxy
```bash
# Configure SSL and routing
ansible-playbook -i inventory.yml traefik-install.yml
```

## 🔧 Key Features

### 🐳 **Smart Docker Setup**
- Automatic mirror configuration for Iran
- Docker Compose support
- Optional Portainer web UI
- Optimized for Iran's restricted networks

### 🌐 **Matrix Communication Platform**
- Full-featured Matrix homeserver (Synapse)
- Element web client hosting
- Jitsi video conferencing integration
- Support for bridges (Discord, Telegram, etc.)
- Advanced features: federation, E2E encryption, admin tools

### 🔒 **Production-Ready Security**
- Automated SSL/TLS with Let's Encrypt
- Traefik reverse proxy with security headers
- Firewall configuration templates

### 📊 **Monitoring & Observability**
- Grafana dashboards
- Prometheus metrics collection
- Log aggregation setup
- Health check automation

## 📚 Documentation

- **Matrix Setup**: [matrix/README.md](matrix/README.md)
- **Docker Role**: [roles/geerlingguy.docker/](roles/geerlingguy.docker/)
- **Traefik Configuration**: [roles/traefik/](roles/traefik/)

## 🔄 Keeping Updated

### Matrix Updates
```bash
# Update Matrix deployment to latest upstream
./bin/matrix-update.ps1
```

### Role Updates
```bash
just roles 
# or
ansible-galaxy install -r requirements.yml --force
```

## 📞 Support

- **Issues**: [GitHub Issues](../../issues)
- **Upstream Matrix Support**: [matrix-docker-ansible-deploy community](https://github.com/spantaleev/matrix-docker-ansible-deploy)

## 📄 License

This repository contains configurations and customizations. Component licenses:
- Matrix deployment: [Upstream license](matrix/matrix-docker-ansible-deploy/LICENSE)
- Custom roles and playbooks: MIT License
- Community roles: See individual role licenses

---

**Built with ❤️**