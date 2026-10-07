{ ... }:
{
  flake.nixosModules.nix =
    { ... }:
    {
      nixpkgs.config.allowUnfree = true;
      programs.nix-ld.enable = true;

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
          trusted-users = [
            "root"
            "@wheel"
          ];
          warn-dirty = false;
        };
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 14d";
        };
        optimise.automatic = true;
      };

      system.stateVersion = "25.11";
    };
}
