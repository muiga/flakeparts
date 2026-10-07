{ inputs, ... }:
{
  flake.nixosModules.flatpak =
    { ... }:
    {
      imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

      services.flatpak = {
        enable = true;

        remotes = [
          {
            name = "flathub";
            location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
          }
        ];

        packages = [
          {
            appId = "com.stremio.Stremio";
            origin = "flathub";
          }
        ];

        uninstallUnmanaged = true;
        update.onActivation = true;
        update.auto = {
          enable = true;
          onCalendar = "weekly";
        };
      };
    };
}
