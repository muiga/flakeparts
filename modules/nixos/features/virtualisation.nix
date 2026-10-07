{ ... }:
{
  flake.nixosModules.virtualisation =
    { ... }:
    {
      virtualisation.docker = {
        enable = true;
        autoPrune = {
          enable = true;
          dates = "weekly";
        };
      };
    };
}
