{ ... }:
{
  flake.nixosModules.virtualisation =
    { ... }:
    {
      virtualisation = {
        podman = {
          enable = true;
          defaultNetwork.settings.dns_enabled = true;
          defaultNetwork.settings.dns = "8.8.8.8";
        };
        docker = {
          enable = true;
          autoPrune.enable = true;
        };
      };
    };
}
