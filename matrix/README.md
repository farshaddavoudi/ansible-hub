# Matrix and Jitsi Deployment

This directory contains the Matrix and Jitsi deployment configuration using Docker and Ansible.

## Overview

This setup uses the [matrix-docker-ansible-deploy](https://github.com/spantaleev/matrix-docker-ansible-deploy) project to deploy a complete Matrix homeserver with Jitsi video conferencing integration.

## Structure

- **Source Repository**: https://github.com/spantaleev/matrix-docker-ansible-deploy
- **Integration Method**: Git subtree
- **Update Script**: `matrix-update.ps1` (located in `../bin/`)

## Features

- 🏠 **Matrix Homeserver**: Full-featured Matrix server deployment
- 🎥 **Jitsi Integration**: Video conferencing capabilities
- 🐳 **Docker-based**: Containerized deployment for easy management
- 🤖 **Ansible Automation**: Infrastructure as Code approach
- 🔧 **Extensible**: Support for bridges, bots, and additional services

## Quick Start

1. [Configure DNS](https://github.com/spantaleev/matrix-docker-ansible-deploy/blob/master/docs/quick-start.md#configure-your-dns-settings)
2. Configure inventory and variables in the `inventory` directory (recommended approach by project doc).
3. Optional: [Update Ansible roles](https://github.com/spantaleev/matrix-docker-ansible-deploy/blob/master/docs/quick-start.md#update-ansible-roles)
3. Run the Ansible playbook to deploy the Matrix server:
> From `matrix-docker-ansible-deploy` root:

_First-time Install_:
```
ansible-playbook -i inventory/hosts setup.yml --tags=install-all,ensure-matrix-users-created,start
```

_Re-turn_:
```
ansible-playbook -i inventory/hosts setup.yml --tags=setup-all,ensure-matrix-users-created,start
```


4. [Create user](https://github.com/spantaleev/matrix-docker-ansible-deploy/blob/master/docs/quick-start.md#create-your-user-account)

## Updating

To update this subtree with the latest changes from the upstream repository:

```powershell
.\bin\matrix-update.ps1
```

## Documentation

Comprehensive documentation is available in the `docs/` directory, covering:
- Initial setup and configuration
- Bridge configurations (Discord, IRC, Slack, etc.)
- Bot integrations
- Backup strategies
- Troubleshooting guides

## Support

For issues related to the Matrix deployment itself, refer to the [upstream repository](https://github.com/spantaleev/matrix-docker-ansible-deploy) and its excellent documentation.