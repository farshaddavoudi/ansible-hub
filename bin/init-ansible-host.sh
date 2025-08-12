#!/bin/bash

# Usage: ./init-ansible-host.sh user@target_host

# Run from Ansible control node
# This script sets up passwordless SSH access to a target host.
# Also creates ansible user on target machine and configure it as passwordless sudoer
# TODO: Can check git installation on control host

# Ensure passlib is installed on the control machine (Ubuntu)
ensure_passlib_installed() {
  # Use Ubuntu package to provide Python 3 passlib (idempotent)
  if dpkg -s python3-passlib >/dev/null 2>&1; then
    echo "passlib (python3-passlib) already installed on control machine."
    return
  fi

  echo "Installing passlib (python3-passlib) on control machine..."
  sudo apt-get update -y
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y python3-passlib
}

# Ensure 'just' command runner is installed on the control machine (Ubuntu)
ensure_just_installed() {
  # Idempotent: if already installed, do nothing
  if command -v just >/dev/null 2>&1; then
    echo "'just' already installed on control machine."
    return
  fi

  echo "Installing 'just' on control machine..."

  # Prefer apt if available and the package exists in repositories
  if command -v apt-get >/dev/null 2>&1; then
    if apt-cache show just >/dev/null 2>&1; then
      sudo apt-get update -y
      if sudo DEBIAN_FRONTEND=noninteractive apt-get install -y just; then
        return
      fi
    fi
  fi

  # Fallback to snap if available
  if command -v snap >/dev/null 2>&1; then
    if sudo snap install just; then
      return
    fi
  fi

  # As a last resort, inform the user but do not fail the script
  echo "Warning: Could not install 'just' automatically. Install manually: https://github.com/casey/just#packages" >&2
}

if [ -z "$1" ]; then
  echo "Usage: $0 <user@target_host>"
  exit 1
fi
TARGET="$1" # user: A privileged user can SSH to target host

# Install tools locally on the control machine (idempotent)
ensure_passlib_installed
ensure_just_installed

# Generate SSH key if it doesn't exist
if [ ! -f "$HOME/.ssh/id_rsa.pub" ]; then
  echo "SSH key not found, generating one..."
  ssh-keygen -t rsa -b 4096 -N "" -f "$HOME/.ssh/id_rsa"
fi

PUBKEY=$(cat ~/.ssh/id_rsa.pub)

ssh "$TARGET" "sudo env PUBKEY='$PUBKEY' bash -s" < ./target-setup.sh
