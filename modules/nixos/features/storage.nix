{ ... }:
{
  flake.nixosModules.storage =
    { ... }:
    {
      services.btrfs.autoScrub = {
        enable = true;
        interval = "monthly";
        fileSystems = [ "/" ];
      };
      services.fstrim.enable = true;

      # services.syncthing = {
      #   enable = true;
      #   user = "muiga";
      #   group = "users";
      #   dataDir = "/home/muiga/Sync";
      #   configDir = "/home/muiga/.config/syncthing";
      #   openDefaultPorts = true;
      # };
    };
}
