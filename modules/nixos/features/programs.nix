{ ... }:
{
  flake.nixosModules.programs =
    { pkgs, ... }:
    {
      programs = {
        dconf.enable = true;
        gamemode.enable = true;
        kdeconnect.enable = true;
        partition-manager.enable = true;
        java.enable = true;
        firefox.enable = true;
        zsh.enable = true;

        steam = {
          enable = true;
          remotePlay.openFirewall = true;
          dedicatedServer.openFirewall = true;
        };

        appimage = {
          enable = true;
          binfmt = true;
        };

        obs-studio = {
          # was programs.programs.obs-studio
          enable = true;
          enableVirtualCamera = true;
          plugins = with pkgs.obs-studio-plugins; [ obs-vaapi ];
        };

      };
    };
}
