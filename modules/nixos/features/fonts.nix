{ ... }:
{
  flake.nixosModules.fonts =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        inter
        carlito
        vegur
        source-code-pro
        meslo-lgs-nf
        jetbrains-mono
        font-awesome
        corefonts
        roboto
        roboto-mono
        roboto-serif
        ibm-plex
      ];

      fonts.fontconfig = {
        enable = true;
        defaultFonts = {
          monospace = [
            "JetBrainsMono Nerd Font Mono"
            "IBM Plex Mono"
          ];
          serif = [
            "Roboto Serif"
            "Inter"
          ];
          sansSerif = [
            "Roboto"
            "Inter"
          ];
        };
      };
    };
}
