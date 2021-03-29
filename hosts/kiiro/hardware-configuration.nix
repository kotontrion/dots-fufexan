# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/b641b204-0b6b-4905-830d-57bce629cfb2";
      fsType = "btrfs";
      options = [ "subvol=nixos" "compress-force=zstd:1" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/9828-7DF4";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/da287a75-894e-4380-a4ab-ba55b485a16d"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
