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
        nerd-fonts.jetbrains-mono
        font-awesome
        corefonts
        roboto
        roboto-mono
        roboto-serif
        ibm-plex
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
      ];

      fonts.fontconfig.defaultFonts = {
        monospace = [
          "JetBrainsMono Nerd Font Mono"
          "IBM Plex Mono"
        ];
        serif = [
          "Roboto Serif"
          "Noto Serif"
        ];
        sansSerif = [
          "Inter"
          "Roboto"
          "Noto Sans"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
}
