{ ... }:
{
  flake.nixosModules.audio =
    { ... }:
    {
      security.rtkit.enable = true;
      services.pulseaudio.enable = false;

      services.pipewire = {
        enable = true;
        audio.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;

        wireplumber = {
          enable = true;
          extraConfig."51-bt-q45" = {
            "monitor.bluez.rules" = [
              # Device-level: codecs and profiles
              {
                matches = [ { "device.name" = "~bluez_card.*"; } ];
                actions.update-props = {
                  "bluez5.codecs" = [
                    "aac"
                    "sbc_xq"
                    "sbc"
                  ];
                  "bluez5.auto-connect" = [ "a2dp_sink" ];
                };
              }
              # Node-level: release the stream when idle
              {
                matches = [ { "node.name" = "~bluez_output.*"; } ];
                actions.update-props = {
                  "node.pause-on-idle" = true;
                  "session.suspend-timeout-seconds" = 5;
                };
              }
            ];
          };
        };
      };
    };
}
