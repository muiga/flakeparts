{ ... }:
{
  flake.nixosModules.mynode =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        nodejs
        pnpm
      ];

      systemd.user.services.corepack-setup = {
        description = "One-time corepack setup";
        wantedBy = [ "default.target" ];
        unitConfig.ConditionPathExists = "!%h/.node/corepack/.setup-done";
        serviceConfig = {
          Type = "oneshot";
          Restart = "on-failure";
          RestartSec = 30;
          ExecStart = pkgs.writeShellScript "corepack-setup" ''
            set -euo pipefail
            export COREPACK_HOME="$HOME/.cache/corepack"
            mkdir -p "$HOME/.node/corepack/bin" "$COREPACK_HOME"
            ${pkgs.nodejs}/bin/corepack enable --install-directory "$HOME/.node/corepack/bin"
            ${pkgs.nodejs}/bin/corepack prepare pnpm@latest --activate
            touch "$HOME/.node/corepack/.setup-done"
          '';
        };
      };

      environment.sessionVariables.COREPACK_HOME = "$HOME/.cache/corepack";
      environment.shellInit = ''
        export PATH="$HOME/.node/corepack/bin:$PATH"
      '';
    };
}
