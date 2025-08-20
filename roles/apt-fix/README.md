# APT Fix Role

A reusable Ansible role that fixes common apt package manager issues on Ubuntu/Debian systems.

## Description

This role resolves common apt-related problems including:
- Lock file conflicts
- Hanging apt processes  
- Corrupted cache
- Interactive prompts during automation
- Repository connectivity issues

## Requirements

- Ubuntu/Debian-based systems
- Ansible 2.9+
- sudo privileges

## Role Variables

Available variables in `defaults/main.yml`:

```yaml
apt_fix_timeout: 300          # Timeout for waiting on locks (seconds)
apt_fix_retries: 5            # Number of retries for apt update
apt_fix_delay: 10             # Delay between retries (seconds)
apt_fix_force_apt_get: true   # Force use of apt-get
apt_fix_backup_config: true   # Backup apt configurations
```

## Example Playbook

### Basic Usage

```yaml
---
- hosts: servers
  become: yes
  roles:
    - apt-fix
  
  tasks:
    - name: Install packages
      apt:
        name:
          - git
          - curl
          - vim
        state: present
```

### With Custom Variables

```yaml
---
- hosts: servers
  become: yes
  roles:
    - role: apt-fix
      vars:
        apt_fix_retries: 3
        apt_fix_timeout: 180
  
  tasks:
    - name: Install Docker
      apt:
        name: docker.io
        state: present
```

### One-liner in existing playbooks

Simply add this at the beginning of any playbook:

```yaml
roles:
  - apt-fix
```

## What This Role Does

1. **Waits for automatic updates** to complete
2. **Kills hanging processes** (apt, dpkg, unattended-upgrade)
3. **Removes lock files** that may be stuck
4. **Configures non-interactive mode** for apt
5. **Cleans corrupted cache** and package lists
6. **Updates package cache** with retry logic
7. **Handles failures gracefully** with fallback methods

## License

MIT

## Author Information

Created for the ansible-hub project.
