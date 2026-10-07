{ ... }:
{
  flake.nixosModules.services =
    { pkgs, ... }:
    {

      services.udev.packages = with pkgs; [
        brightnessctl
      ];
      services.fprintd.enable = true;
      services.fwupd.enable = true;
      # Removable drives, trash, MTP, network mounts
      services.udisks2.enable = true;
      services.gvfs.enable = true;
      # thumbnails, location
      services.tumbler.enable = true;
      services.geoclue2.enable = true;
      # Warp
      services.cloudflare-warp.enable = true;

    };
}
