FROM python:3.11-alpine

# Install required system packages
RUN apk add --no-cache \
    openssh-client \
    sshpass \
    git \
    bash

# Install Ansible and required Python packages
RUN pip install --no-cache-dir \
    ansible \
    ansible-vault \
    cryptography

# Create necessary directories
RUN mkdir -p /ansible/playbooks /etc/ansible

# Set working directory
WORKDIR /ansible/playbooks

# Create ansible config file with some basic settings
RUN echo "[defaults]\n\
host_key_checking = False\n\
inventory = /ansible/playbooks/inventory\n\
roles_path = /ansible/playbooks/roles\n\
" > /etc/ansible/ansible.cfg

# Create a non-root user for running ansible
RUN adduser -D ansible
USER ansible

# Set default command
CMD ["ansible", "--version"] 