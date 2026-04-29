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
        #xdg-desktop-portal-gnome
        #xdg-desktop-portal-gtk
        #xdg-desktop-portal
        gpu-screen-recorder
        cliphist
        noctalia-shell
      ];

      services.tuned.enable = true;
      services.upower.enable = true;
      services.udev.packages = [ pkgs.brightnessctl ];
    };

}
