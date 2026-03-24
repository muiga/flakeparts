{ self, inputs, ... }:
{
  flake.nixosConfigurations.thinkbook = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.thinkbookConfiguration
    ];
  };
}
