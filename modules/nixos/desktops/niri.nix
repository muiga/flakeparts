{ ... }:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      programs.niri = {
        enable = true;
      };

      environment.systemPackages = with pkgs; [
        xwayland-satellite
        quickshell
        brightnessctl
        gpu-screen-recorder
        cliphist
        noctalia-shell
        wl-clipboard
      ];

      # Login manager
      services.displayManager.sddm.enable = true;
      services.displayManager.sddm.wayland.enable = true;

      # Portals: file pickers, screen sharing, dark-mode setting
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

      # Electron/Chromium apps run natively on Wayland
      environment.sessionVariables.NIXOS_OZONE_WL = "1";

    };

}
