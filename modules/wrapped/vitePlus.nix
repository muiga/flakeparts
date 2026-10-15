{ inputs, ... }:
{
  flake.nixosModules.vite-plus =
    { pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    {
      environment.systemPackages = [ inputs.vite-plus.packages.${system}.vp ];
    };
}
