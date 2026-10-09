{ inputs, ... }:
{
  flake.nixosModules.homeManager =
    { ... }:
    {
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "bak"; # stops "file already exists" errors on first run
        users.muiga = import ./_home.nix;
      };
    };
}
