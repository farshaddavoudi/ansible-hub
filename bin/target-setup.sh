#!/bin/bash

# Variables
ANSIBLE_USER="ansible"
SSH_DIR="/home/$ANSIBLE_USER/.ssh"

# 1. Create ansible user (if not exists)
if ! id "$ANSIBLE_USER" &>/dev/null; then
  sudo adduser --disabled-password --gecos "" "$ANSIBLE_USER"
  echo "[+] User '$ANSIBLE_USER' created."
else
  echo "[=] User '$ANSIBLE_USER' already exists."
fi

# 2. Add ansible user to sudo group
sudo usermod -aG sudo "$ANSIBLE_USER"

# 3. Allow passwordless sudo for ansible user
echo "$ANSIBLE_USER ALL=(ALL) NOPASSWD: ALL" | sudo tee "/etc/sudoers.d/$ANSIBLE_USER" > /dev/null
sudo chmod 0440 "/etc/sudoers.d/$ANSIBLE_USER"

# 4. Create .ssh directory for ansible user
sudo mkdir -p "$SSH_DIR"
sudo chmod 700 "$SSH_DIR"
sudo chown "$ANSIBLE_USER:$ANSIBLE_USER" "$SSH_DIR"

# 5. Add public key passed as environment variable PUBKEY
if [[ -n "$PUBKEY" ]]; then
  echo "$PUBKEY" > "$SSH_DIR/authorized_keys"
  chmod 600 "$SSH_DIR/authorized_keys"
  chown "$ANSIBLE_USER:$ANSIBLE_USER" "$SSH_DIR/authorized_keys"
  echo "[+] Public key added to $SSH_DIR/authorized_keys"
else
  echo "[!] No public key provided — skipping."
fi

echo "[✅] Target machine is ready for Ansible."
