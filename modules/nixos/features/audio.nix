{ ... }:
{
  flake.nixosModules.audio =
    { ... }:
    {
      security.rtkit.enable = true;
      services.pulseaudio.enable = false;

      # services.pipewire = {
      #   enable = true;
      #   alsa.enable = true;
      #   alsa.support32Bit = true;
      #   audio.enable = true;
      #   pulse.enable = true;
      #   jack.enable = true;
      #   wireplumber = {
      #     enable = true;
      #     extraConfig."51-bt-q45" = {
      #       "monitor.bluez.rules" = [
      #         {
      #           matches = [
      #             {
      #               "device.name" = "~bluez_card.*";
      #             }
      #           ];
      #           actions = {
      #             update-props = {
      #               "bluez5.codecs" = [
      #                 "aac"
      #                 "sbc_xq"
      #                 "sbc"
      #               ];
      #               "bluez5.auto-connect" = [ "a2dp_sink" ];
      #               "bluez5.a2dp.auto-suspend" = true;
      #               "bluez5.a2dp.auto-suspend-delay-ms" = 500;
      #               "bluez5.a2dp.auto-suspend-mode" = "release";
      #             };
      #           };
      #         }
      #       ];
      #     };
      #   };

      #   extraConfig.pipewire."92-bt-release" = {
      #     "context.properties" = {
      #       "bluez5.a2dp.auto-suspend" = true;
      #     };
      #   };
      # };
      #
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        audio.enable = true;
        pulse.enable = true;
        jack.enable = true;

        extraConfig.pipewire."92-bt-release" = {
          "context.properties" = {
            "bluez5.a2dp.auto-suspend" = true;
          };
        };

        wireplumber = {
          enable = true;
          extraConfig."51-bt-q45" = {
            "monitor.bluez.rules" = [
              {
                matches = [ { "device.name" = "~bluez_card.*"; } ];
                actions = {
                  update-props = {
                    "bluez5.codecs" = [
                      "aac"
                      "sbc_xq"
                      "sbc"
                    ];
                    "bluez5.auto-connect" = [ "a2dp_sink" ];
                    "bluez5.a2dp.auto-suspend" = true;
                    "bluez5.a2dp.auto-suspend-delay-ms" = 100;
                    "bluez5.a2dp.auto-suspend-mode" = "release";
                    "node.pause-on-idle" = true;
                    "session.suspend-timeout-seconds" = 1;
                  };
                };
              }
            ];
          };
        };
      };

    };
}
