{ ... }:
{
  flake.nixosModules.audio =
    { ... }:
    {
      security.rtkit.enable = true;
      services.pulseaudio.enable = false;

      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        audio.enable = true;
        pulse.enable = true;
        jack.enable = true;
        wireplumber.enable = true;

        extraConfig = {
          pipewire."10-no-suspend" = {
            "context.properties" = {
              "suspend-timeout-seconds" = 0;
            };
          };
          pipewire-pulse."bluetooth-policy" = {
            "bluez5.roles" = [ "a2dp_sink" ];
          };
        };
      };
    };
}
