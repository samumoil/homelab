This guide is a copy from a [Stack Exchange question](https://superuser.com/questions/1804774/persistent-promiscuous-mode-in-debian-12) I asked and answered myself.

**Debian 12 Bookworm cloudinit uses systemd-networkd**

Turns out systemd-networkd completely bypasses `/etc/network/interface` and changes in that file do not propagate. You can solve this by disabling systemd-networkd, but I suspect they have a reason to use it. Thus, I solved the problem using a modified version of a systemd service from [this post](https://alias454.com/using-a-systemd-service-file-to-control-promiscuous-mode-automatically-at-boot/).

**Solution #1**

We'll add a service to activate command `ip link set eth0 promisc on` at boot:

1. Add this service file `promisc.service` in `/etc/systemd/system/`
```
[Unit]
Description=Control promiscuous mode for interface eth0
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/bin/ip link set eth0 promisc on
ExecStop=/usr/bin/ip link set eth0 promisc off
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

2. Enable the service with
`sudo systemctl enable promisc.service`

3. Reboot and `ip a` should show "PROMISC"
```
2: eth0: <BROADCAST,MULTICAST,PROMISC,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
```


**Solution #2**

User [Tom Yan](https://superuser.com/users/554702/tom-yan) pointed to [systemd documentation](https://www.freedesktop.org/software/systemd/man/systemd.network.html) which provided another solution. You can add a config file in `/etc/systemd/network/` and set promiscuous mode there. 

***Steps for Debian 12 cloudinit***

1. List contents of directory `/run/systemd/network/` and check files with `.network` suffix. One of them (or the only one) should contain IP address provided by your cloudinit image. Mine was `10-netplan-eth0.network`.
2. Create directory `/etc/systemd/network/<name-of-file>.d/`. Use the filename from previous step.
3. Create a file in that directory with a suffix `.conf`, any name will do. Add following in that file (use whatever network interface name you want to affect, mine is `eth0`):
```
[Match]
Name=eth0

[Link]
Promiscuous=true
```
4. Reboot and check network interface with `ip a`.
