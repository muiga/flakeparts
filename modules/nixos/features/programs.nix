{ ... }:
{
  flake.nixosModules.programs =
    { ... }:
    {
      programs = {
        nix-ld.enable = true;
        nix-ld.libraries = [ ];
        dconf.enable = true;
        gamemode.enable = true;
        kdeconnect.enable = true;
        partition-manager.enable = true;
        java.enable = true;
        steam = {
          enable = true;
          remotePlay.openFirewall = true;
          dedicatedServer.openFirewall = true;
        };
      };

      security.polkit.enable = true;

      services.xserver = {
        enable = false;
        xkb.layout = "us";
        xkb.variant = "";
      };

      services.openssh = {
        enable = true;
        allowSFTP = true;
        extraConfig = ''
          HostKeyAlgorithms +ssh-rsa
        '';
      };

      services.flatpak.enable = true;
    };
}
