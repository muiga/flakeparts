{ ... }:
{
  flake.nixosModules.auth =
    { pkgs, ... }:
    {
      security.polkit.enable = true;
      services.gnome.gnome-keyring.enable = true;

      # Unlock the keyring at login (match your display manager)
      security.pam.services.sddm.enableGnomeKeyring = true;
      security.pam.services.login.enableGnomeKeyring = true;

      programs.seahorse.enable = true; # GUI to manage keys and passwords

      systemd.user.services.polkit-gnome-agent = {
        description = "polkit-gnome authentication agent";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };
}
