{
  config,
  pkgs,
  ...
}:
with config;
with pkgs;
{
  boot = {
#    consoleLogLevel = 0;
    initrd = {
      availableKernelModules = [
#        "ahci"		#
        "ehci_pci"	
        "sd_mod"	
#        "sr_mod"	#
#        "uas"		#
        "usb_storage"	
        "usbhid"	
        "xhci_pci"	
        "nvme"		
	"rtsx_pci_sdmmc" 
      ];
#      kernelModules = [
#        "amdgpu"
#      ];
#      verbose = false;
    };
#    kernel = {
#      sysctl = {
#        "vm.swappiness" = 1;
#      };
#    };
    kernelModules = [
      "kvm-amd"
      #"kvm-intel"
      #"snd-aloop"
      #"v4l2loopback"
    ];
#    kernelPackages = linuxPackages-rt_latest;
    kernelParams = [
#      "quiet"
#      "mitigations=off"
#      "udev.log_level=3"
    ];
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        configurationLimit = 20; # Maximum number of latest generations in boot menu.
      };
      efi = {
        canTouchEfiVariables = true;
      };
#      grub = {
#        useOSProber = false;
#        splashImage = null;
#      };
      timeout = 5;
    };
    plymouth = {
      enable = false;
    };
#    extraModulePackages = with config.boot.kernelPackages; [
#      v4l2loopback.out
#    ];
#    extraModprobeConfig = ''
#      options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
#    '';
  };
}
