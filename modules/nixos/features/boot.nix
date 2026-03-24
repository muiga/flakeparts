{ ... }:
{
  flake.nixosModules.boot =
    { ... }:
    {
      boot = {
        loader = {
          systemd-boot = {
            enable = true;
            configurationLimit = 3;
          };
          efi.canTouchEfiVariables = true;
          timeout = 1;
        };
        kernel.sysctl = {
          "swappiness" = 10;
        };
      };

      systemd.settings.Manager.DefaultTimeoutStopSec = "30s";
    };
}
