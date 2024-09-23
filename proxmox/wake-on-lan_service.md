https://forum.proxmox.com/threads/wake-on-lan-wol-for-vms-and-containers.143879/


# Create Wake-On-LAN script​
1. Click on your Proxmox Node and go to "Shell"​
2. Type in cd ~ followed by mkdir scripts, then navigate into that folder with cd scripts​
3. Next type in nano wol_hack.sh and paste the following script into that file (credit goes to @henr0 - Source):​
4. Make the script executable (chmod +x)

```
Bash:

#!/bin/bash

# Attempts to start Proxmox VM or LXC that matches MAC address received on WOL message
# This could be dangerous if abused by spamming the interface with many packages
# so I would like to try no more than once per 5 seconds.
# In my case useful with Moonlight client
# Uses tcpdump on default proxmox interface, change the interface if needed.
while true; do
  sleep 5
  wake_mac=$(tcpdump -c 1 -UlnXi vmbr1 ether proto 0x0842 or udp port 9 2>/dev/null |\
  sed -nE 's/^.*20:  (ffff|.... ....) (..)(..) (..)(..) (..)(..).*$/\2:\3:\4:\5:\6:\7/p')
  echo "Captured magic packet for address: \"${wake_mac}\""
  echo -n "Looking for existing VM: "
  matches=($(grep -il ${wake_mac} /etc/pve/qemu-server/*))
  if [[ ${#matches[*]} -eq 0 ]]; then
    echo "${#matches[*]} found"
  echo -n "Looking for existing LXC: "
  matches=($(grep -il ${wake_mac} /etc/pve/lxc/*))
  if [[ ${#matches[*]} -eq 0 ]]; then
    echo "${#matches[*]} found"
    continue
  elif [[ ${#matches[*]} -gt 1 ]]; then
    echo "${#matches[*]} found, using first found"
  else
    echo "${#matches[*]} found"
  fi
  vm_file=$(basename ${matches[0]})
  vm_id=${vm_file%.*}
  details=$(pct status ${vm_id} -verbose | egrep "^name|^status")
  name=$(echo ${details} | awk '{print $2}')
  status=$(echo ${details} | awk '{print $4}')
  if [[ "${status}" != "stopped" ]]; then
    echo "SKIPPED CONTAINER ${vm_id} : ${name} is ${status}"
  else
    echo "STARTING CONTAINER ${vm_id} : ${name} is ${status}"
    pct start ${vm_id}
  fi
    continue
  elif [[ ${#matches[*]} -gt 1 ]]; then
    echo "${#matches[*]} found, using first found"
  else
    echo "${#matches[*]} found"
  fi
  vm_file=$(basename ${matches[0]})
  vm_id=${vm_file%.*}
  details=$(qm status ${vm_id} -verbose | egrep "^name|^status")
  name=$(echo ${details} | awk '{print $2}')
  status=$(echo ${details} | awk '{print $4}')
  if [[ "${status}" != "stopped" ]]; then
    echo "SKIPPED VM ${vm_id} : ${name} is ${status}"
  else
    echo "STARTING VM ${vm_id} : ${name} is ${status}"
    qm start ${vm_id}
  fi
done
```


#Add new auto-start service​
1. Create a new systemd service file with the following command: nano /etc/systemd/system/pve-wakeonlanhack.service​
2. Paste the following code into this file (credit goes to @jacobxtyler - Source)
3. Enable and Start this service via the following commands:​
```systemctl enable pve-wakeonlanhack​```
```systemctl start pve-wakeonlanhack​```

```
[Unit]
Description=Wake-on-LAN for Proxmox Virtual Environments
After=network.target

[Service]
Type=simple
Restart=always
User=root
ExecStart=/root/scripts/wol_hack.sh

[Install]
WantedBy=multi-user.target
```


WOL should now work :) 
If something doesn't work or if a VM/Container doesn't want to wake up you can check the log output via systemctl status pve-wakeonlanhack and see what it does. A successful boot attempt should look like this:

```
wol_hack.sh[2000563]: Captured magic packet for address: "xx:xx:xx:xx:xx:x"
wol_hack.sh[2000563]: Looking for existing VM: 1 found
wol_hack.sh[2000563]: STARTING VM 900 : Win11Desktop is stopped
qm[2001050]: <root@pam> starting task UPID:pve2:XXXXXXXX:XXXXXXXX:XXXXXXXX:qmstart:900:root@pam:
qm[2001051]: start VM 900: UPID:pve2:XXXXXXXX:XXXXXXXX:XXXXXXXX:qmstart:900:root@pam:
wol_hack.sh[2001050]: swtpm_setup: Not overwriting existing state file.
qm[2001050]: <root@pam> end task UPID:pve2:XXXXXXXX:XXXXXXXX:XXXXXXXX:qmstart:900:root@pam: OK
```

# Troubleshooting​


- error: stdbuf: failed to run command ‘xxd’: No such file or directory
        - (Might not be an issue anymore as the script above got rewritten, but mentioning this just in case)
	- Some people have reported this in the original thread which seems to be an issue with older Proxmox installs. Try to install the following package which should resolve this: apt install xxd
- WOL packets from pfSense aren't working
```
            jaffo73 said:
            pfSense sends WOL packets on 40000 so change the vmbr1 to vmbr0 (the Proxmox default bridge) and port 9 to 40000 and restart the script. All devices woke up within a second of sending the WOL packet. 
```
