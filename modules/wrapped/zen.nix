{ inputs, ... }:
{
  flake.nixosModules.zen-browser =
    { pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    {
      environment.systemPackages = [ inputs.zen-browser.packages.${system}.beta ];
    };
}
