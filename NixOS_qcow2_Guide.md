# Guide: Using a Pre-made NixOS qcow2 Image in Proxmox

This guide explains how to create a NixOS qcow2 image and how to use it to create a new virtual machine in Proxmox. This method is faster than installing from an ISO and allows for more customized and reproducible builds.

---

## Part 1: Creating a NixOS qcow2 Image

You can create a qcow2 image from any NixOS configuration. This is done by building a specific derivation that produces a virtual machine image.

### 1.1 Create a Configuration File

First, create a NixOS configuration file for your image. Let's call it `qcow-image.nix`. This file will define the system that will be packaged into the qcow2 image.

Here is an example configuration. It's similar to a standard `configuration.nix`, but with a few additions for a VM image.

```nix
# qcow-image.nix
{ config, pkgs, ... }:

{
  # Use the latest stable release.
  system.stateVersion = "23.11";

  # Set the filesystem type.
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  # Bootloader configuration
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda"; # or "nodev" for OVMF

  # Proxmox guest agent
  services.qemuGuest.enable = true;

  # Enable SSH
  services.openssh.enable = true;
  
  # Allow password authentication for the first boot.
  # It's recommended to switch to key-based auth after initial setup.
  services.openssh.settings.PasswordAuthentication = true;

  # Create a user
  users.users.sam = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # for sudo
    initialPassword = "changeme"; # Set a temporary password
  };
  
  # Set a root password
  users.users.root.initialPassword = "changeme";

  # Define the image format
  format = "qcow2";
  
  # Enable cloud-init for initial setup in Proxmox
  services.cloud-init.enable = true;
}
```

### 1.2 Build the qcow2 Image

Now, you can build the qcow2 image using the `nix-build` command. This command will download all the necessary packages and build the image according to your configuration.

```bash
nix-build '<nixpkgs/nixos>' -A vm -I nixos-config=./qcow-image.nix
```

This command will create a `result` symlink in your current directory, which points to the built image in the Nix store. The qcow2 image itself will be located at `result/nixos.qcow2`.

---

## Part 2: Using the qcow2 Image in Proxmox

Now that you have your `nixos.qcow2` file, you can use it to create a new VM in Proxmox.

### 2.1 Upload the Image to Proxmox

First, copy the `nixos.qcow2` file to your Proxmox server. You can use `scp` for this.

```bash
scp result/nixos.qcow2 root@your-proxmox-server:/var/lib/vz/template/qcow/
```

### 2.2 Create a New VM

Next, create a new VM in the Proxmox web UI:

1.  **General:** Give it a name (e.g., `nixos-from-qcow`).
2.  **OS:** Select "Do not use any media".
3.  **System:** Set the **Graphic card** to `SPICE` and **Machine** to `q35`. Use `OVMF (UEFI)` for the BIOS and add an EFI disk.
4.  **Hard Disk:** You can delete the default hard disk, as you will be importing your own.
5.  **CPU/Memory/Network:** Configure these as needed.

### 2.3 Import the qcow2 Disk

Now, import the qcow2 disk into your newly created VM. Run this command on your Proxmox server's shell:

```bash
qm importdisk <vmid> /var/lib/vz/template/qcow/nixos.qcow2 <storage-pool>
```

-   Replace `<vmid>` with the ID of the VM you just created.
-   Replace `<storage-pool>` with the name of the storage pool where you want to store the disk (e.g., `local-lvm`).

This will create a new disk in your VM's hardware tab, usually named `unused0`.

### 2.4 Attach the Disk and Configure Boot Order

1.  Go to the **Hardware** tab of your VM in the Proxmox UI.
2.  You will see the imported disk as "Unused Disk 0". Click on it and then "Edit".
3.  Set the **Bus/Device** to `VirtIO Block` and click "Add".
4.  Go to the **Options** tab of your VM and change the **Boot Order** to make your new disk the first boot device.

### 2.5 Resize the Disk

The imported disk will have the size defined by the image. You can resize it to a larger size:

1.  Select the disk in the **Hardware** tab.
2.  Click on **Disk Action** and then **Resize**.
3.  Enter the additional size you want to add to the disk.

After booting into NixOS, you can use `growpart` and `resize2fs` to expand the filesystem to use the new space.

### 2.6 (Optional) Use Cloud-Init for Initial Setup

Cloud-init is the industry standard for cross-platform cloud instance initialization. It allows you to automate the initial setup of a new VM on its first boot. This is particularly useful when deploying VMs from a generic image, as it allows you to configure things like networking, hostnames, users, and SSH keys without manual intervention.

If you enabled `cloud-init` in your NixOS image, you can take advantage of this feature in Proxmox.

#### How it works in Proxmox

Proxmox allows you to attach a "CloudInit Drive" to your VM. This drive is a virtual CD-ROM that contains configuration data in the form of `user-data`, `meta-data`, and `network-config` files. When the VM boots, cloud-init reads these files and configures the system accordingly.

#### Configuration Steps

1.  **Add a CloudInit Drive:** In your VM's **Hardware** tab in the Proxmox UI, click on **Add** and select **CloudInit Drive**.

2.  **Configure Cloud-Init:** Go to the **Cloud-Init** tab of your VM. Here you can define the configuration that will be passed to cloud-init.

    -   **User:** Define the username and password.
    -   **SSH Public Key:** Add your SSH public key for secure, passwordless access.
    -   **IP Config:** Configure the network interface (DHCP or static).
    -   **Custom User Data / Network Config:** For more advanced configurations, you can provide your own `user-data` and `network-config` files.

#### Example: `user-data`

The `user-data` file is used for general instance configuration. Here is a more detailed example that you can use in the **Custom User Data** field in the Proxmox UI:

```yaml
#cloud-config

# Set the hostname
hostname: nixos-server

# Set a password for the 'sam' user and ensure it doesn't expire
user: sam
password: your-secure-password
chpasswd: { expire: false }

# Add SSH public keys to the 'sam' user
ssh_authorized_keys:
  - "ssh-ed25519 AAAA... your-public-key"

# Run commands on the first boot
runcmd:
  - [ touch, /tmp/cloud-init-was-here ]
  - [ "echo", "Cloud-init ran successfully!" ]
```

#### Example: `network-config` for a Static IP

If you want to configure a static IP address, you can use the **Custom Network Config** field.

```yaml
version: 2
ethernets:
  ens18: # Replace with your network interface
    dhcp4: no
    addresses: [192.162.1.100/24]
    gateway4: 192.168.1.1
    nameservers:
      addresses: [8.8.8.8, 8.8.4.4]
```

#### Starting the VM

Once you have configured cloud-init, you can start your VM. On the first boot, cloud-init will apply all the configurations.

#### Debugging Cloud-Init

If you encounter any issues, you can check the cloud-init logs on the VM to see what happened:

```bash
# Check the main log file
cat /var/log/cloud-init.log

# For more detailed output
cat /var/log/cloud-init-output.log
```

Now, you can start your VM. It should boot into your pre-configured NixOS system.
