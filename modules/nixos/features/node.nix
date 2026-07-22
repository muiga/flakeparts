{ ... }:
{
  flake.nixosModules.mynode =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        nodejs
      ];

      # Enable corepack and install specific versions
      # environment.shellInit = ''
      #   export COREPACK_HOME="$HOME/.cache/corepack"
      #   export PATH="$HOME/.node/corepack/bin:$PATH"

      #   # Create directories
      #   mkdir -p "$HOME/.node/corepack/bin"
      #   mkdir -p "$HOME/.cache/corepack"

      #   # Enable corepack with install directory
      #   corepack enable --install-directory "$HOME/.node/corepack/bin"

      #   # Prepare versions
      #   corepack prepare npm@latest --activate
      #   corepack prepare pnpm@latest --activate
      # '';

      systemd.user.services.corepack-setup = {
        description = "One-time corepack setup";
        wantedBy = [ "default.target" ];
        unitConfig.ConditionPathExists = "!%h/.node/corepack/.setup-done";
        serviceConfig = {
          Type = "oneshot";
          ExecStart = pkgs.writeShellScript "corepack-setup" ''
            export COREPACK_HOME="$HOME/.cache/corepack"
            mkdir -p "$HOME/.node/corepack/bin" "$HOME/.cache/corepack"
            ${pkgs.nodejs}/bin/corepack enable --install-directory "$HOME/.node/corepack/bin"
            ${pkgs.nodejs}/bin/corepack prepare npm@latest --activate
            ${pkgs.nodejs}/bin/corepack prepare pnpm@latest --activate
            touch "$HOME/.node/corepack/.setup-done"
          '';
        };
      };

      environment.shellInit = ''
        export COREPACK_HOME="$HOME/.cache/corepack"
        export PATH="$HOME/.node/corepack/bin:$PATH"
      '';

    };
}
