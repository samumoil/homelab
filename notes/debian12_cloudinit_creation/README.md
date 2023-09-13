# How to create Debian 12 cloudinit templates in Proxmox

Guide copied and modified from [https://ochoaprojects.github.io/posts/ProxMoxCloudInitImage/](https://ochoaprojects.github.io/posts/ProxMoxCloudInitImage/)

### 0. SSH into Proxmox

### 1. Download Debian 12 cloudinit image

Latest Debian 12 cloudinit images can be found [here](https://cloud.debian.org/images/cloud/bookworm/latest/)
Image used in Proxmox is "genericcloud": [https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2](https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2)

`cd ~ && mkdir temp && cd temp`
`wget https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2`

### 2. Create virtual machine, configurate it and turn it into template

```
qm create 9999 --name Debian12CloudInit --net0 virtio,bridge=vmbr0
qm importdisk 9999 debian-12-genericcloud-amd64.qcow2 local-lvm
qm set 9999 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9999-disk-0
qm set 9999 --ide2 local-lvm:cloudinit
qm set 9999 --boot c --bootdisk scsi0
qm set 9999 --agent enabled=1
qm template 9999
```

### 3. Configure template further

This section is still done by hand. Sometime in the future this is done by Terrafrom.

- CPU count
- Memory size
- Resize harddisk to at least 5 Gb
- SSH keys
- DNS servers
- IP address


