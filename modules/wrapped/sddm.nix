{ ... }:
{
  flake.nixosModules.sddmWallpaper =
    { pkgs, ... }:
    {
      systemd.tmpfiles.rules = [ "d /var/lib/sddm-wallpaper 0755 root root -" ];

      systemd.services.sddm-wallpaper-sync = {
        description = "Copy Noctalia wallpaper for the SDDM greeter";
        wantedBy = [ "multi-user.target" ];
        path = [
          pkgs.jq
          pkgs.coreutils
        ];
        serviceConfig.Type = "oneshot";
        script = ''
          src=$(jq -r '
            ((.wallpapers // {}) | to_entries | .[0].value
              | if type == "object" then (.dark // .light) else . end)
            // .defaultWallpaper // empty
          ' /home/muiga/.cache/noctalia/wallpapers.json)

          if [ -z "$src" ] || [ ! -f "$src" ]; then
            echo "wallpaper not found: '$src'"
            exit 0
          fi
          install -m 644 "$src" /var/lib/sddm-wallpaper/current.jpg
        '';
      };

      systemd.paths.sddm-wallpaper-sync = {
        wantedBy = [ "multi-user.target" ];
        pathConfig.PathChanged = "/home/muiga/.cache/noctalia/wallpapers.json";
      };
    };
}
