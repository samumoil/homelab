# External HDD with zfs mirroring for backups

These steps follow this video:  
https://youtu.be/-wlbvt9tM-Q?feature=shared  

0) Check correct disk. If needed, install zfs (guide for fedora: https://openzfs.github.io/openzfs-docs/Getting%20Started/Fedora/index.html)  
If you have trouble updating system after that guide, use  
`dnf update --exclude=kernel*`  
`lsblk`  

1) Create new GPT label on the disk  
`parted /dev/sda mklabel gpt`

2) Create sufficient amount of partitions for your needs. Four (4) should be good.  
`parted /dev/[sda] mkpart zfs 0% 25%`  
`parted /dev/[sda] mkpart zfs 25% 50%`  
`parted /dev/[sda] mkpart zfs 50% 75%`  
`parted /dev/[sda] mkpart zfs 75% 100%`  

3) Create ZFS raidz1 pool with the partitions.
`zpool create extbackup1 raidz1 /dev/sda[1-4]`  
(Check disk)
`zpool status extbackup1`  

4) Create a dataset.  
With no special options.  
`zfs create extbackup1/dataset1`  
With gzip compression.  
`zfs create -o compression=gzip extbackup1/gzip`  
With gzip and encryption. Prompt for passphrase.  
`zfs create -o compression=gzip -o encryption=on -o keylocation=prompt -o keyformat=passphrase extbackup1/private`

## Additional commands to use with zfs
Check filesystem space usage:  
`zfs list -o space extbackup1`  

Check data integrity:  
`zpool scrub extbackup1`

Destroy a dataset:  
`zfs destroy extbackup1/dataset1`  

Check compressratio:  
`zfs get compressratio extbackup1/gzip`

Import/export zpool:  
`zpool import extbackup1`  
`zpool export extbackup1`  

Import encrypted dataset:  
`zfs load-key extbackup1/private`  
`zfs mount extbackup1/private`  

Create timestamped snapshots:  
`zfs snapshot extbackup1/private@$(date +%Y-%m-%d-%H%M)`

Access created snapshots (CLI autofill will NOT find `.zfs/snapshot/`):  
`cd extbackup1/private/.zfs/snapshot/`

Delete snapshots:  
`zfs destroy extbackup1/private@2024-07-11-2226`  








