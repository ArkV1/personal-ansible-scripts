# openSUSE Post-Installation Steps

## 1. Disable Automatic Snapshots
```bash
# Disable YaST snapshots
sudo nano /etc/sysconfig/yast2
# Set USE_SNAPPER=no

# Remove zypper snapshot plugin
sudo zypper remove snapper-zypp-plugin --clean-deps

# Clean snapshots created by plugin removal
snapper list
sudo snapper delete [N-1]-[N]  # Delete latest two snapshots

# Disable timeline snapshots
sudo snapper -c root set-config "TIMELINE_CREATE=no"
```

## 2. Setup Encryption Key File
```bash
# Create keys directory and key file
sudo mkdir -p /etc/keys
sudo touch /etc/keys/enc.key
sudo chmod 600 /etc/keys/enc.key

# Generate random key
sudo dd if=/dev/urandom of=/etc/keys/enc.key bs=1024 count=1

# Add key to encrypted partition
sudo cryptsetup luksAddKey /dev/sda1 /etc/keys/enc.key

# Add key file to crypttab
sudo nano /etc/crypttab
# Find root partition UUID and add /etc/keys/enc.key

# Configure dracut to include key file
echo -e 'install_items+=" /etc/keys/enc.key "' | sudo tee --append /etc/dracut.conf.d/99-root-key.conf

# Rebuild initrd
sudo dracut -f
```

Note: Replace /dev/sda1 with your encrypted partition (find with `sudo lsblk`).