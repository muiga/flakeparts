{ self, ... }:
{

  flake.nixosModules.thinkbookConfiguration =
    { ... }:
    {
      # import any other modules from here
      imports = [
        self.nixosModules.thinkbookHardware
        self.nixosModules.niri
        self.nixosModules.boot
        self.nixosModules.networking
        self.nixosModules.hardwareEnable
        self.nixosModules.audio
        self.nixosModules.printing
        self.nixosModules.storage
        self.nixosModules.virtualisation
        self.nixosModules.programs
        self.nixosModules.packages
        self.nixosModules.fonts
        self.nixosModules.nix
      ];

      # ...
    };

}
