https://forum.proxmox.com/threads/pci-gpu-passthrough-on-proxmox-ve-8-installation-and-configuration.130218/

https://gist.github.com/peterkir/cbe7b6e8982e97e6f86f7413c3db7674


# BIOS
- Check VT-d and other virtualization support
- Check IOMMU

# Bootloader configuration

## GRUB

        nano /etc/default/grub

For an Intel processor, use the following configuration:

        GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on iommu=pt"

        update-grub

Verify IOMMU isolation (https://pve.proxmox.com/wiki/PCI_Passthrough#Verify_IOMMU_isolation)

        pvesh get /nodes/{nodename}/hardware/pci --pci-class-blacklist ""


# VFIO modules and verification of remapping support

Next, we need to incorporate several VFIO modules into our Proxmox system. Add the following lines to /etc/modules:

        echo "vfio" >> /etc/modules
        echo "vfio_iommu_type1" >> /etc/modules
        echo "vfio_pci" >> /etc/modules

Subsequently, update the initramfs images and restart Proxmox:

        update-initramfs -u -k all
        systemctl reboot

After the system reboots, you can inspect the status of the VFIO modules by running:

        dmesg | grep -i vfio

The output should resemble the following:

        [ 7.262027] VFIO - User Level meta-driver version: 0.3

Verification of whether your system supports interrupt remapping:

        dmesg | grep 'remapping'

If the command returns: AMD-Vi: Interrupt remapping enabled" or "DMAR-IR: Enabled IRQ remapping in x2apic mode, then remapping is supported. Otherwise,
you can enable insecure interrupts with:

        echo "options vfio_iommu_type1 allow_unsafe_interrupts=1" > /etc/modprobe.d/iommu_unsafe_interrupts.conf

# GPU isolation

## Find IDs

Before blacklisting drivers, we need to find out PCI IDs for the cards:

        lspci -nn | grep 'NVIDIA'

We need vendor ID and device ID. They are (almost) last part of this line:

        01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere [Radeon RX 470/480/570/570X/580/580X/590] [1002:67df] (rev e7)

        [1002:67df]

Grab both VGA and sound devices, so two pairs of IDs.

## Isolation

Use those IDs in this command:

        echo "options vfio-pci ids=1002:67df,1002:aaf0" > /etc/modprobe.d/vfio.conf

## Driver blacklisting

### AMD drivers

        echo "blacklist radeon" >> /etc/modprobe.d/blacklist.conf
        echo "blacklist amdgpu" >> /etc/modprobe.d/blacklist.conf

### NVIDIA drivers

        echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf
        echo "blacklist nvidia" >> /etc/modprobe.d/blacklist.conf
        echo "blacklist nvidiafb" >> /etc/modprobe.d/blacklist.conf
        echo "blacklist nvidia_drm" >> /etc/modprobe.d/blacklist.conf

### Intel drivers

        echo "snd_hda_intel" >> /etc/modprobe.d/blacklist.conf
        echo "snd_hda_codec_hdmi" >> /etc/modprobe.d/blacklist.conf
        echo "i915" >> /etc/modprobe.d/blacklist.conf

