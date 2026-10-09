{ ... }:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    let
      astronaut = pkgs.sddm-astronaut.override {
        embeddedTheme = "astronaut";
        themeConfig.Background = "/var/lib/sddm-wallpaper/current";
      };
    in
    {
      programs.niri.enable = true;

      environment.systemPackages = with pkgs; [
        xwayland-satellite
        noctalia-shell
        brightnessctl
        gpu-screen-recorder
        cliphist
        wl-clipboard
        bibata-cursors
        astronaut
      ];

      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        package = pkgs.kdePackages.sddm;
        theme = "sddm-astronaut-theme";
        extraPackages = with pkgs.kdePackages; [
          qtmultimedia
          qtsvg
          qtvirtualkeyboard
        ];
      };

      xdg.portal = {
        enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gnome
          pkgs.xdg-desktop-portal-gtk
        ];
        config.niri.default = [
          "gnome"
          "gtk"
        ];
      };

      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        XCURSOR_THEME = "Bibata-Modern-Classic";
        XCURSOR_SIZE = "18";
      };
    };
}
