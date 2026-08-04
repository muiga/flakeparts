{ ... }:
{
  flake.nixosModules.pixelFlasher =
    { pkgs, ... }:

    {
      environment.systemPackages = [
        (pkgs.pixelflasher.overrideAttrs (oldAttrs: rec {
          version = "9.1.5.0"; # Replace with the latest release version number from GitHub

          src = pkgs.fetchFromGitHub {
            owner = "badabing2005";
            repo = "PixelFlasher";
            rev = "v${version}";
            # Leave this empty first; Nix will throw an error and give you the correct hash to paste here
            hash = "";
          };
        }))
      ];
    };
}
