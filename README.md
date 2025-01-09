# openSUSE Post-Installation Ansible Playbook

This Ansible playbook automates common post-installation tasks for openSUSE systems, including:
- Disabling automatic snapshots
- Setting up disk encryption key file

## Features

- ✨ Automatic detection of encrypted partitions
- 🔍 System compatibility verification
- 🔐 Interactive LUKS passphrase prompt
- ⚡ Smart detection of existing configurations
- 🛡️ Safe handling of existing encryption keys
- 📊 Detailed completion summary

## Prerequisites

- Ansible installed on the control machine
- SSH access to target machines
- sudo privileges on target machines

## Configuration

The playbook can run with minimal configuration, as it will automatically detect most settings. However, you can still pre-configure variables if desired:

1. Copy `vars/main.yml` to `vars/main.local.yml` and optionally configure variables:
   ```yaml
   # Optional: Override automatic detection
   encrypted_partition: /dev/sdX
   # Optional: Provide passphrase non-interactively
   luks_passphrase: "your_current_passphrase"
   ```

2. If using variables file, secure it:
   ```bash
   ansible-vault encrypt vars/main.local.yml
   ```

## Usage

Run the playbook:
```bash
# With automatic detection (recommended)
ansible-playbook -i inventory opensuse-post-install.yml

# With encrypted variables file
ansible-playbook -i inventory opensuse-post-install.yml --ask-vault-pass
```

## Interactive Prompts

The playbook will automatically prompt for:
- LUKS passphrase (if not provided in variables)
- Confirmation before overwriting existing encryption keys
- Other safety confirmations as needed

## Automatic Detection

The playbook automatically:
- Verifies the target system is openSUSE
- Detects encrypted partitions
- Checks if snapper is installed
- Verifies current snapshot configuration
- Determines if initrd rebuild is needed

## Important Notes

- Always backup your system before running this playbook
- The playbook will only modify snapper configuration if it's installed
- Encrypted partition detection is automatic, but can be overridden
- The playbook runs safety checks before critical operations

## Security Considerations

- Sensitive information is handled securely with no_log
- Passphrases can be provided interactively or through ansible-vault
- File permissions are properly set and verified
- Keep backups of your encryption keys in a secure location 