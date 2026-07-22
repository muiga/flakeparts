{ ... }:
{
  flake.nixosModules.packages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        epson-escpr2
        ffmpegthumbnailer
        openssl
        fwupd
        sbctl
        niv
        android-tools
        polkit
        syncthing
        gitRepo
        fastfetch
        wget
        curl
        git
        stow
        efibootmgr
        usbutils
        fprintd
        libfprint
        vlc
        brave
        mkcert
        nssTools
        inkscape-with-extensions
        haruna
        motrix
        # nodejs
        htop
        ferdium
        libreoffice-fresh
        pdfarranger
        ffmpeg
        yt-dlp
        libva
        libva-utils
        mpv
        bottom
        appimage-run
        bruno
        vscode.fhs
        joplin-desktop
        gimp3-with-plugins
        google-chrome
        jq
        #cloudflare-warp
        #cloudflared
        docker-compose
        #ngrok
        anydesk
        libusb1
        ghostscript
        musicpod
        pnpm
        winbox
        tmux
        localsend
        kitty
        #megasync
        #mailspring
        eog
        zed-editor-fhs
        nil
        nixd
        pywalfox-native
        cloudflare-warp
        anydesk
        lm_sensors
        blueman
        btop
        kdePackages.kruler
      ];

      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          obs-vaapi
        ];
      };

      environment.shells = with pkgs; [ zsh ];
    };
}
