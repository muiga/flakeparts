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

      services.tuned.enable = true;
      services.upower.enable = true;
      services.udev.packages = [ pkgs.brightnessctl ];
    };

}
