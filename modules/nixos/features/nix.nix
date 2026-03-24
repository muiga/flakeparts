{ ... }:
{
  flake.nixosModules.nix =
    { ... }:
    {
      nix = {
        settings = {
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          max-jobs = "auto";
          cores = 0;
          use-xdg-base-directories = true;
          http-connections = 50;
        };
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };
      };

      system = {
        autoUpgrade.enable = true;
        stateVersion = "25.11";
      };
    };
}
