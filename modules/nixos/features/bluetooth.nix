{ ... }:
{
  flake.nixosModules.bluetooth =
    { ... }:
    {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings.General = {
          FastConnectable = true;
          MultiProfile = "multiple";
          Experimental = true;
        };
      };

      services.blueman.enable = true;
    };
}
