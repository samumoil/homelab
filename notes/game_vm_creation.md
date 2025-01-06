- sshd config + enable systemctl
- bash aliases
- dnf update
- Install utilities
	dnf install btop htop screen tree flatpak
- RPM Fusion + Verify GPG signatures on install
	dnf install distribution-gpg-keys
	rpmkeys --import /usr/share/distribution-gpg-keys/rpmfusion/RPM-GPG-KEY-rpmfusion-free-fedora-$(rpm -E %fedora)
	dnf --setopt=localpkg_gpgcheck=1 install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 
- RPM Fusion more
	dnf config-manager setopt fedora-cisco-openh264.enabled=1
- Add flathub repo	
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
- Set autologin /etc/lightdm/lightdm.conf
- Install steam first so we can observe gpu driver installation
	dnf install steam
- Set off: screensaver, autolock, power management



## Autologin
Nvidia drivers mess up autologin via display manager

	systemctl edit getty@tty1

	[Service]
	ExecStart=
	ExecStart=-/sbin/agetty --autologin $username --noclear %I $TERM

Put in ~/.bash_profile
	[ "$(tty)" = "/dev/tty1" ] && exec startx

Make system boot to tty
	systemctl set-default multi-user.target

(Revert back to lightdm)
	systemctl set-default graphical.target



- Install NVIDIA drivers and nvtop to follow gpu usage
	dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda nvtop
After the RPM transaction ends, please remember to wait until the kmod has been built. This can take up to 5 minutes on some systems.
Once the module is built, ´´modinfo -F version nvidia´´ should outputs the version of the driver such as 440.64 and not modinfo: ERROR: Module nvidia not found. 
Follow installation with btop open, you can see CPU usage while dnf is building kmod.

## Sunshine
- Install sunshine as flatpak
	flatpak install sunshine
- Install additional stuff. Run in remote desktop!!!
	flatpak run --command=additional-install.sh dev.lizardbyte.app.Sunshine
- Default autostart doesn't work because lightdm is disabled. Instead use XFCE autostart.
- Add XFCE autostart of command
	flatpak run --command=sunshine dev.lizardbyte.app.Sunshine
- Open firewall ports in VM
	firewall-cmd --permanent --add-port={47984/tcp,47989/tcp,47990/tcp,48010/tcp,47998/udp,47999/udp,48000/udp}
	firewall-cmd --reload
	firewall-cmd --list-ports





https://www.reddit.com/r/cloudygamer/comments/1ad8bdg/how_to_perfectly_optimize_sunshine_and_moonlight/
