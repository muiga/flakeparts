{ ... }:
{
  flake.nixosModules.mynode =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        nodejs
      ];

      # Enable corepack and install specific versions
      environment.shellInit = ''
        export PATH="$HOME/.node/corepack/bin:$PATH"
        corepack enable
        corepack prepare npm@latest --activate
        corepack prepare pnpm@latest --activate
      '';
    };
}
