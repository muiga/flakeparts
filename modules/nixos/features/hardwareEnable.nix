{ ... }:
{
  flake.nixosModules.hardwareEnable =
    { pkgs, ... }:
    {
      hardware = {

        bluetooth = {
          enable = true;
          powerOnBoot = true;
          settings = {
            General = {
              # Enable = "Source,Sink,Media,Socket";
              FastConnectable = true;
              MultiProfile = "multiple";
              Experimental = true;
              # ControllerMode = "dual";
            };
          };
        };
        graphics = {
          enable = true;
          enable32Bit = true;
          extraPackages = with pkgs; [
            amdvlk
            rocm-opencl-icd
            mesa
            libva-vdpau-driver
            libvdpau-va-gl
          ];
        };
      };

      # programs.light.enable = true; # alternative

      services.udev.packages = with pkgs; [
        libusb1
      ];
      services.fprintd.enable = true;
      services.fwupd.enable = true;
      services.tuned.enable = true;
      services.upower.enable = true;
      # services.blueman.enable = true;

    };
}
