# FRESH INSTALL

## apt repository changes

- /etc/apt/sources.list.d/pve-enterprise.list

From: deb https://enterprise.proxmox.com/debian/pve bookworm enterprise
To: deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription

- /etc/apt/sources.list.d/ceph.list
- For Ceph Quincy
From: deb https://enterprise.proxmox.com/debian/ceph-quincy bookworm enterprise
To: deb http://download.proxmox.com/debian/ceph-quincy bookworm no-subscription

- For Ceph Reef
From: deb https://enterprise.proxmox.com/debian/ceph-reef bookworm enterprise
To: deb http://download.proxmox.com/debian/ceph-reef bookworm no-subscription

## Install needed apps
- utilities and network file sharing stuff:
apt install screen htop btop bat tree nfs-kernel-server nfs-common rpcbind cifs-utils sudo

- tailscale:
curl -fsSL https://tailscale.com/install.sh | sh


## NFS JAKO:
apt install nfs-kernel-server nfs-common rpcbind

mkdir -P /samu/nfs/
??? chmod 777? ???

nano /etc/exports
	/samu/nfs/dockerhost 10.10.10.200(rw,sync,no_subtree_check)

- Aktivoi nfs jaon:
exportfs -ra

- Näyttää jaot:
showmount -e

- Client connection kertaluontoinen
mkdir <mountfolder>
sudo mount <IP>:/samu/nfs/dockerhost <mountfolder>

- Persistent client connection to nfs share, in /etc/fstab
<IP>:/samu/nfs/dockerhost <mountfolder> nfs rw 0 0






- Boot order:
1 dns
2 truenas, delay 60
any

- /etc/fstab
//10.10.10.122/services /samu/smb-services cifs credentials=/samu/.smb_credentials,uid=101000,gid=100000,rw,iocharset=utf8 0 0
//10.10.10.122/cloud /samu/smb-cloud cifs credentials=/samu/.smb_credentials,uid=101000,gid=100000,rw,iocharset=utf8 0 0


# This is needed on proxmox host, because unprivileged containers don't have
# permissions to read or write bind mounts. Users inside LXC have their
# UID/GID numbers be UID/GID+100000. These commands create 
groupadd -g 100000 containerroot
groupadd -g 101000 container
# Use '!' as password, it denies login for that user.
adduser --uid 101000 --gid 101000 container
chown -R container:containerroot <container-share-folder>

# You could also just use uid-gid in chown
chwon -R 100000:101000 <container-share-folder>

BIND-MOUNT to containers:
pct set <CTID> -mp0 <proxmox-folder>,mp=<container-folder>



