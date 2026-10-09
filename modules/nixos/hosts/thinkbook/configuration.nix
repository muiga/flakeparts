{ self, ... }:
{

  flake.nixosModules.thinkbookConfiguration =
    { ... }:
    {
      # import any other modules from here
      imports = [
        self.nixosModules.thinkbookHardware
        self.nixosModules.disko
        self.nixosModules.boot
        self.nixosModules.packages
        self.nixosModules.networking
        self.nixosModules.audio
        self.nixosModules.fonts
        self.nixosModules.nix
        self.nixosModules.printing
        self.nixosModules.storage
        self.nixosModules.virtualisation
        self.nixosModules.niri
        self.nixosModules.zsh
        self.nixosModules.backlight
        self.nixosModules.flatpak
        self.nixosModules.zen-browser
        self.nixosModules.mynode
        self.nixosModules.pixelFlasher
        self.nixosModules.users
        self.nixosModules.services
        self.nixosModules.power
        self.nixosModules.auth
        self.nixosModules.bluetooth
        self.nixosModules.hardwareEnable
        self.nixosModules.programs
        self.nixosModules.sddmWallpaper
      ];

      networking.hostName = "thinkbook"; # Define your hostname.
      # Set your time zone.
      time.timeZone = "Africa/Nairobi";
      # Select internationalisation properties.
      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings.LC_TIME = "en_GB.UTF-8"; # 24h clock, if you prefer it

      security.pki.certificateFiles = [
        ./certs/rootCA.pem
      ];

    };

}
