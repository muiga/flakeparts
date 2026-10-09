{ config, pkgs, ... }:
{
  home.stateVersion = "25.11";

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 18;
    gtk.enable = true;
    x11.enable = true;
  };

  # Dark GTK / Qt, like GNOME or KDE
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  # Niri config, edited in the repo and reloaded by niri without a rebuild
  xdg.configFile."niri/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink "/home/muiga/flakeparts/modules/niri/config.kdl";
  xdg.configFile."niri/noctalia.kdl".source =
    config.lib.file.mkOutOfStoreSymlink "/home/muiga/flakeparts/modules/niri/noctalia.kdl";

  # Standard folders (Pictures, Downloads, ...)
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # Default applications
  # xdg.mimeApps = {
  #   enable = true;
  #   defaultApplications = {
  #     "inode/directory" = "org.gnome.Nautilus.desktop";
  #     "application/pdf" = "org.gnome.Papers.desktop";
  #     "image/png" = "org.gnome.Loupe.desktop";
  #     "image/jpeg" = "org.gnome.Loupe.desktop";
  #   };
  # };

  # Automount USB drives
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "never";
  };
}
