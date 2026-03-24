{ self, inputs, ... }:
{

  flake.nixosModules.thinkbookConfiguration =
    { pkgs, lib, ... }:
    {
      # import any other modules from here
      imports = [
        self.nixosModules.thinkbookHardware
        self.nixosModules.niri
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      # ...
    };

}
