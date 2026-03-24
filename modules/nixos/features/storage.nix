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

      # services.syncthing = {
      #   enable = true;
      #   user = "muiga";
      #   dataDir = "/home/muiga/Sync";
      #   configDir = "/home/muiga/Sync/.config/syncthing";
      # };
    };
}
