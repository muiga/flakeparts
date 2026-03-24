{ ... }:
{
  flake.nixosModules.printing =
    { pkgs, ... }:
    {
      services.printing = {
        enable = true;
        drivers = [ pkgs.epson-escpr2 ];
      };

      services.avahi = {
        enable = true;
        nssmdns4 = true;
        publish = {
          enable = true;
          addresses = true;
          userServices = true;
        };
      };
    };
}
