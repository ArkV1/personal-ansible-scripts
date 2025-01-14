# Docker-based Ansible Control Node

This directory contains Docker configuration for running Ansible in a container, eliminating the need to install Ansible and its dependencies on your local machine.

## Prerequisites

- Docker
- Docker Compose
- SSH keys for connecting to target hosts

## Quick Start

1. Build and start the container:
```bash
docker-compose up -d
```

2. Verify the setup:
```bash
docker-compose run --rm ansible ansible --version
```

## Usage

### Running Playbooks
```bash
# Run a playbook
docker-compose run --rm ansible ansible-playbook opensuse-post-install.yml

# Run playbook with vault
docker-compose run --rm ansible ansible-playbook opensuse-post-install.yml --ask-vault-pass
```

### Using Ansible Commands
```bash
# List inventory
docker-compose run --rm ansible ansible-inventory --list

# Ping hosts
docker-compose run --rm ansible ansible all -m ping
```

## Container Details

The container is built on Alpine Linux and includes:
- Python 3.11
- Ansible and ansible-vault
- SSH client and supporting tools
- Git for version control
- Basic security configurations

## Volume Mounts

- `.:/ansible/playbooks`: Mounts your local Ansible files into the container
- `~/.ssh:/home/ansible/.ssh:ro`: Mounts your SSH keys (read-only) for host access

## Security Notes

- The container runs as a non-root user
- SSH keys are mounted read-only
- Host key checking is disabled by default for convenience (can be enabled if needed)

## Customization

To modify the container configuration:
1. Edit the `Dockerfile` to add packages or change settings
2. Edit `docker-compose.yml` to modify volume mounts or environment variables
3. Rebuild the container:
```bash
docker-compose build --no-cache
docker-compose up -d
``` 