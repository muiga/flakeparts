{ ... }:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      programs.niri = {
        enable = true;
        # package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
      };

      environment.systemPackages = with pkgs; [
        xwayland-satellite
        rofi
        swaybg
        quickshell
        hyprlock
        hypridle
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

  # perSystem =
  #   {
  #     pkgs,
  #     ...
  #   }:
  #   {
  #     packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
  #       inherit pkgs; # THIS PART IS VERY IMPORTAINT, I FORGOT IT IN THE VIDEO!!!
  #       # settings = {
  #       #   spawn-at-startup = [
  #       #     (lib.getExe self'.packages.myNoctalia)
  #       #   ];

  #       #   xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

  #       #   input.keyboard.xkb.layout = "us,ua";

  #       #   layout.gaps = 5;

  #       #   binds = {
  #       #     "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
  #       #     "Mod+Q".close-window = null;
  #       #     "Mod+S".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
  #       #   };
  #       # };
  #     };
  #   };
}
