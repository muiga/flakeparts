{ ... }:
{
  flake.nixosModules.thinkbookHardware =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      boot.kernelPackages = pkgs.linuxPackages_latest;
      boot.initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "usbhid"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];
      boot.kernelModules = [ "kvm-amd" ];
      hardware.amdgpu.initrd.enable = true; # replaces boot.initrd.kernelModules = [ "amdgpu" ]
      networking.useDHCP = lib.mkDefault false; # NetworkManager handles DHCP
      hardware.enableRedistributableFirmware = lib.mkDefault true;
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    };
}
