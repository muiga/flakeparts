{ inputs, ... }:
{
  flake.nixosModules.homeManager =
    { ... }:
    {
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "bak";
        users.muiga = import ./_home.nix;
      };
    };
}
