{ ... }:
{
  flake.nixosModules.boot =
    { ... }:
    {
      boot = {
        loader = {
          systemd-boot = {
            enable = true;
            configurationLimit = 5;
          };
          efi.canTouchEfiVariables = true;
          timeout = 3;
        };
        kernel.sysctl."vm.swappiness" = 10;
      };

      systemd.settings.Manager.DefaultTimeoutStopSec = "30s";
    };
}
