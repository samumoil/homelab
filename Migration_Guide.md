# Homelab Migration Guide: From Multiple VMs to a Single NixOS Server

This guide provides a comprehensive walkthrough for migrating your services from separate Debian-based virtual machines (`dns`, `upkeep`, `swag`) to a single, unified NixOS server.

This migration will help you to:
- **Simplify Management:** Manage all your services from a single `configuration.nix` file.
- **Improve Reproducibility:** Easily recreate your entire setup on a new machine.
- **Gain Stability:** Benefit from the atomic upgrades and rollbacks of NixOS.

---

## Part 1: Setting up your NixOS VM in Proxmox

This section will walk you through setting up a new NixOS virtual machine in Proxmox.

### 1.1 Download NixOS ISO

First, you need to download the latest NixOS minimal installation ISO image. You can find the latest stable release here:

[https://nixos.org/download.html](https://nixos.org/download.html)

Download the "Minimal installation CD" image and upload it to your Proxmox server's local storage. You can usually do this by navigating to your Proxmox server's web UI, selecting a storage pool, and using the "Upload" button.

### 1.2 Create a New VM in Proxmox

Next, create a new virtual machine in Proxmox with the following settings:

- **General:**
    - **Name:** Give your VM a descriptive name (e.g., `nixos-server`).
    - **VM ID:** Choose a unique ID.
- **OS:**
    - **Type:** `Linux`
    - **Version:** `5.x - 2.6 Kernel`
    - **Use CD/DVD disc image file (iso):** Select the NixOS ISO you uploaded earlier.
- **System:**
    - **Graphic card:** `SPICE` (for better performance, if you have a SPICE client) or `Default`.
    - **Machine:** `q35`
    - **BIOS:** `OVMF (UEFI)`
    - **Add EFI Disk:** Check this box and select a storage pool for the EFI disk.
- **Hard Disk:**
    - **Bus/Device:** `VirtIO Block`
    - **Disk size:** Choose a suitable size for your needs (e.g., 64GB).
    - **Storage:** Select the storage pool for your VM's disk.
- **CPU:**
    - **Cores:** Allocate at least 4 cores.
- **Memory:**
    - **Memory (MiB):** Allocate at least 4096 MiB of RAM.
- **Network:**
    - **Bridge:** Select the appropriate bridge for your network.
    - **Model:** `VirtIO (paravirtualized)`

Once you've configured the VM, start it up and open the console.

### 1.3 Install NixOS

You will be greeted by the NixOS installer. Follow these steps to partition the disk and install NixOS:

1.  **Switch to the root user:**
    ```bash
    sudo -i
    ```

2.  **Partition the disk:**
    You can use a tool like `gdisk` or `parted` to partition your disk. Here's an example using `gdisk` to create a single partition for the root filesystem:

    ```bash
    gdisk /dev/vda
    ```

    - `n` to create a new partition.
    - Press Enter to accept the default partition number, first sector, and last sector.
    - `w` to write the changes to the disk.

3.  **Format the partition:**
    Format the new partition with a filesystem like `ext4`:

    ```bash
    mkfs.ext4 /dev/vda1
    ```

4.  **Mount the filesystem:**
    Mount the new partition to `/mnt`:

    ```bash
    mount /dev/vda1 /mnt
    ```

5.  **Generate the NixOS configuration:**
    Generate a basic NixOS configuration file:

    ```bash
    nixos-generate-config --root /mnt
    ```

6.  **Edit the configuration:**
    Now, you need to edit the `configuration.nix` file to configure your system. You can use the `nano` editor, which is available in the installer environment:

    ```bash
    nano /mnt/etc/nixos/configuration.nix
    ```

    Here are some essential settings you should configure:

    - **Bootloader:**
      ```nix
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      ```

    - **Networking:**
      Enable networking and set a hostname:
      ```nix
      networking.hostName = "nixos-server";
      networking.useDHCP = true; # You might want to set a static IP later
      ```

    - **Users:**
      Set a password for the `root` user and create a new user:
      ```nix
      users.users.root.initialHashedPassword = "your_hashed_password_here";
      users.users.sam = {
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" ]; # for sudo and docker access
        initialHashedPassword = "your_hashed_password_here";
      };
      ```
      To generate a hashed password, you can use the `mkpasswd` command in another terminal: `mkpasswd -m sha-512`

    - **Enable SSH:**
      ```nix
      services.openssh.enable = true;
      ```
    - **Enable Docker:**
      ```nix
      virtualisation.docker.enable = true;
      ```

7.  **Install NixOS:**
    Once you've saved the configuration file, run the installer:

    ```bash
    nixos-install
    ```

8.  **Reboot:**
    After the installation is complete, reboot the VM:

    ```bash
    reboot
    ```

    Don't forget to remove the installation ISO from the VM's CD/DVD drive in the Proxmox UI.

---

## Part 2: Migrating Your Services

Now that you have a running NixOS VM, it's time to migrate your services. This involves adding the necessary configuration to your `/etc/nixos/configuration.nix` file and copying over your existing data.

### 2.1 DNS Services (Pi-hole & Unbound)

#### Configuration:
```nix
# /etc/nixos/configuration.nix

services.unbound = {
  enable = true;
  settings = {
    server = {
      interface = [ "0.0.0.0" ];
      access-control = [ "10.0.0.0/8 allow" ];
      # Add any other custom settings from your existing unbound.conf here
    };
  };
};

virtualisation.oci-containers.containers."pihole" = {
  image = "pihole/pihole:latest";
  ports = [ "53:53/tcp", "53:53/udp", "80:80/tcp", "443:443/tcp" ];
  environment = {
    TZ = "Europe/Helsinki";
    WEBPASSWORD_FILE = "/run/secrets/webpassword";
    REV_SERVER = "true";
    REV_SERVER_TARGET = "10.10.10.1";
    REV_SERVER_CIDR = "10.0.0.0/8";
    PIHOLE_DOMAIN = "peikkoluola";
    DNS_BOGUS_PRIV = "true";
    DNS_FQDN_REQUIRED = "true";
    DNSMASQ_LISTENING = "all";
    PIHOLE_DNS_ = "127.0.0.1"; # Points to the local Unbound service
  };
  volumes = [
    "/data/pihole/etc-pihole:/etc/pihole"
    "/data/pihole/etc-dnsmasq.d:/etc/dnsmasq.d"
  ];
  secrets."webpassword".file = "/data/pihole/webpassword";
};
```

#### Data Migration:
1.  **Unbound:** Copy the settings from your old `unbound.conf` into the `services.unbound.settings` section of your `configuration.nix`.
2.  **Pi-hole:**
    - Create the directory `/data/pihole` on your NixOS VM.
    - Copy the contents of `/samu/pihole/` from your old `dns` VM to `/data/pihole/` on the new VM.
    - Ensure the `webpassword` file is present in `/data/pihole/`.

---

### 2.2 Upkeep Services (UniFi, Portainer, Uptime Kuma, LibreSpeed)

#### Configuration:
```nix
# /etc/nixos/configuration.nix

virtualisation.oci-containers.containers = {
  "unifi-controller" = {
    image = "ghcr.io/linuxserver/unifi-controller";
    ports = [ "3478:3478/udp", "10001:10001/udp", "8080:8080", "8443:8443", "1900:1900/udp", "8843:8843", "8880:8880", "6789:6789", "5514:5514/udp" ];
    environment = { PUID = "1000"; PGID = "1000"; TZ = "Europe/Helsinki"; MEM_LIMIT = "1024"; };
    volumes = [ "/data/unifi:/config" ];
  };

  "portainer" = {
    image = "portainer/portainer-ce";
    ports = [ "9000:9000" "8000:8000" ];
    volumes = [ "/var/run/docker.sock:/var/run/docker.sock", "/data/portainer:/data" ];
  };

  "portainer-agent" = {
    image = "portainer/agent";
    ports = [ "9001:9001" ];
    volumes = [ "/var/run/docker.sock:/var/run/docker.sock", "/var/lib/docker/volumes:/var/lib/docker/volumes" ];
  };

  "uptime-kuma" = {
    image = "louislam/uptime-kuma:1";
    ports = [ "3001:3001" ];
    volumes = [ "/data/uptime-kuma:/app/data" ];
  };

  "librespeed" = {
    image = "lscr.io/linuxserver/librespeed:latest";
    ports = [ "8081:80" ]; # Note: Port changed to 8081 to avoid conflict with Pi-hole
    environment = { PUID = "1000"; PGID = "1000"; TZ = "Europe/Helsinki"; };
    volumes = [ "/data/librespeed:/app/data" ];
  };
};
```

#### Data Migration:
- Create the directories `/data/unifi`, `/data/portainer`, `/data/uptime-kuma`, and `/data/librespeed`.
- Copy the contents of the corresponding `/samu/...` directories from your old `upkeep` VM to the new `/data/...` directories on your NixOS VM.

---

### 2.3 Gateway Services (SWAG & Homepage)

#### Configuration:
```nix
# /etc/nixos/configuration.nix

virtualisation.oci-containers.containers = {
  "swag" = {
    image = "lscr.io/linuxserver/swag:latest";
    ports = [ "443:443", "80:80" ];
    capAdd = [ "NET_ADMIN" ];
    environment = {
      PUID = "1000"; PGID = "1000"; TZ = "Europe/Helsinki";
      URL = "peikkoluola.com"; VALIDATION = "dns"; SUBDOMAINS = "wildcard";
      DNSPLUGIN = "cloudflare"; PROPAGATION = "30";
    };
    volumes = [ "/data/swag:/config" ];
  };

  "homepage" = {
    image = "ghcr.io/gethomepage/homepage:latest";
    ports = [ "3000:3000" ];
    volumes = [ "/data/homepage:/app/config" ];
  };
};
```

#### Data Migration:
- Create the directories `/data/swag` and `/data/homepage`.
- Copy the contents of `/samu/swag` and `/samu/homepage` from your old `swag` VM to the corresponding `/data/...` directories on your NixOS VM.

---

## Part 3: Finalizing the Migration

1.  **Combine Configurations:** You should merge all the container definitions into a single `virtualisation.oci-containers.containers` block in your `configuration.nix`.

2.  **Apply Changes:** After you have added all the configurations and copied all the data, run the following command to apply the new configuration:
    ```bash
    sudo nixos-rebuild switch
    ```

3.  **Verify:** Check that all your services are running correctly. You may need to update DNS records to point to the new IP address of your NixOS VM.

Congratulations! You have successfully migrated your homelab services to a single NixOS server. You can now enjoy the benefits of a declarative, reproducible, and robust system.
