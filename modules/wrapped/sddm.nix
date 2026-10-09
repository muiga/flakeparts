{ ... }:
{
  flake.nixosModules.sddmWallpaper =
    { pkgs, ... }:
    {
      systemd.tmpfiles.rules = [ "d /var/lib/sddm-wallpaper 0755 root root -" ];

      systemd.services.sddm-wallpaper-sync = {
        description = "Copy Noctalia wallpaper for the SDDM greeter";
        wantedBy = [ "multi-user.target" ]; # also runs once at boot
        path = [
          pkgs.jq
          pkgs.coreutils
        ];
        serviceConfig.Type = "oneshot";
        script = ''
          src=$(jq -r '.defaultWallpaper // ((.wallpapers // {}) | to_entries | .[0].value) // empty' \
            /home/muiga/.cache/noctalia/wallpapers.json)
          [ -n "$src" ] && [ -f "$src" ] || exit 0
          install -m 644 "$src" /var/lib/sddm-wallpaper/current
        '';
      };

      systemd.paths.sddm-wallpaper-sync = {
        wantedBy = [ "multi-user.target" ];
        pathConfig.PathChanged = "/home/muiga/.cache/noctalia/wallpapers.json";
      };
    };
}
