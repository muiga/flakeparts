{ self, inputs, ... }:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
      };
    };

  perSystem =
    {
      pkgs,
      lib,
      self',
      config,
      ...
    }:
    {
      packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs; # THIS PART IS VERY IMPORTAINT, I FORGOT IT IN THE VIDEO!!!
        settings = {
          prefer-no-csd = true;

          # input
          input = {
            keyboard = {
              repeat-rate = 35;
              repeat-delay = 200;
              numlock = true;
              xkb = { };
            };

            touchpad = {
              tap = true;
              dwt = true;
            };

            mouse = { };
            trackpoint = { };

            focus-follows-mouse = {
              enable = true;
            };
          };

          # outputs
          outputs."eDP-1" = {
            mode = {
              width = 1920;
              height = 1080;
              refresh = 60.01;
            };
            scale = 1.0;
            transform = "normal";
            position = {
              x = 0;
              y = 0;
            };
          };

          # workspaces
          workspaces = [
            { name = "top"; }
            { name = "main"; }
          ];

          # layout
          layout = {
            gaps = 5;
            center-focused-column = "never";

            preset-column-widths = [
              { proportion = 0.5; }
              { proportion = 0.66667; }
              { proportion = 1.0; }
            ];

            default-column-width = {
              proportion = 1.0;
            };

            focus-ring = {
              enable = false;
              width = 1;
              active-color = "#cba6f7";
              inactive-color = "#505050";
            };

            border = {
              enable = true;
              width = 2;
              active-color = "#cba6f7";
              inactive-color = "#505050";
              urgent-color = "#9b0000";
            };

            struts = {
              top = -2;
              bottom = -4;
              left = -2;
              right = -2;
            };
          };

          # Startup
          spawn-at-startup = [
            { command = [ (lib.getExe self'.packages.myNoctalia) ]; }
            { command = [ (lib.getExe self'.packages.myHypridle) ]; }
          ];

          hotkey-overlay = { };

          # Events
          switch-events = {
            lid-close.action.spawn = [ (lib.getExe self'.packages.myHyprlock) ];
          };

          screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

          animations = { };

          overview = { };

          # Window rules
          window-rules = [
            {
              matches = [ { app-id = "^org\\.wezfurlong\\.wezterm$"; } ];
              default-column-width = { };
            }
            {
              matches = [ { app-id = "xdg.desktop-portal"; } ];
              open-floating = true;
              open-focused = true;
              min-height = 700;
              min-width = 750;
            }
            {
              matches = [
                {
                  app-id = "zen-twilight";
                  title = "^Zen Twilight";
                }
              ];
              open-maximized = true;
              open-on-workspace = "top";
            }
            {
              matches = [ { app-id = "Code"; } ];
              open-maximized = true;
            }
            {
              matches = [ { app-id = "org\\.kde\\.haruna"; } ];
              open-maximized = true;
            }
            {
              matches = [
                {
                  app-id = "firefox$";
                  title = "^Picture-in-Picture$";
                }
              ];
              open-floating = true;
            }
            {
              geometry-corner-radius = {
                top-left = 8.0;
                top-right = 8.0;
                bottom-left = 8.0;
                bottom-right = 8.0;
              };
              clip-to-geometry = true;
            }
          ];

          # Layer rules
          layer-rules = [
            {
              matches = [ { namespace = "^noctalia-overview*"; } ];
              place-within-backdrop = true;
            }
          ];

          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          binds = with config.lib.niri.actions; {
            # "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
            # "Mod+Q".close-window = null;
            # "Mod+S".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";

            # carried forward
            "Mod+Shift+Slash".action = show-hotkey-overlay;
            "Mod+T".action = spawn "konsole";
            "Mod+Space".action = spawn-sh "${lib.getExe self'.packages.myRofi} -show drun";
            "Mod+Alt+L".action = spawn "${lib.getExe self'.packages.myHyprlock}";
            "Mod+Alt+S".action = spawn-sh "pkill orca || exec orca";
            "Mod+Shift+E".action = quit;
            "Ctrl+Alt+Delete".action = quit;

            "Mod+Q".action = close-window;
            "Mod+O".action = toggle-overview;
            "Mod+Shift+P".action = power-off-monitors;
            "Mod+Escape".action = toggle-keyboard-shortcuts-inhibit;

            "XF86AudioRaiseVolume".action = spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
            "XF86AudioLowerVolume".action = spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
            "XF86AudioMute".action = spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            "XF86AudioMicMute".action = spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

            "XF86MonBrightnessUp".action = spawn "brightnessctl" "--class=backlight" "set" "+10%";
            "XF86MonBrightnessDown".action = spawn "brightnessctl" "--class=backlight" "set" "10%-";

            "XF86AudioPlay".action = spawn "playerctl" "play-pause";
            "XF86AudioStop".action = spawn "playerctl" "stop";
            "XF86AudioNext".action = spawn "playerctl" "next";
            "XF86AudioPrev".action = spawn "playerctl" "previous";

            "Print".action = screenshot;
            "Ctrl+Print".action = screenshot-screen;
            "Alt+Print".action = screenshot-window;

            "Mod+Left".action = focus-column-left;
            "Mod+Right".action = focus-column-right;
            "Mod+H".action = focus-column-left;
            "Mod+L".action = focus-column-right;
            "Mod+Home".action = focus-column-first;
            "Mod+End".action = focus-column-last;

            "Mod+Down".action = focus-window-down;
            "Mod+Up".action = focus-window-up;
            "Mod+J".action = focus-window-down;
            "Mod+K".action = focus-window-up;

            "Mod+Shift+Left".action = focus-monitor-left;
            "Mod+Shift+Down".action = focus-monitor-down;
            "Mod+Shift+Up".action = focus-monitor-up;
            "Mod+Shift+Right".action = focus-monitor-right;
            "Mod+Shift+H".action = focus-monitor-left;
            "Mod+Shift+J".action = focus-monitor-down;
            "Mod+Shift+K".action = focus-monitor-up;
            "Mod+Shift+L".action = focus-monitor-right;

            "Mod+Page_Down".action = focus-workspace-down;
            "Mod+Page_Up".action = focus-workspace-up;
            "Mod+U".action = focus-workspace-down;
            "Mod+I".action = focus-workspace-up;

            "Mod+WheelScrollDown".action = focus-workspace-down;
            "Mod+WheelScrollUp".action = focus-workspace-up;
            "Mod+WheelScrollRight".action = focus-column-right;
            "Mod+WheelScrollLeft".action = focus-column-left;
            "Mod+Shift+WheelScrollDown".action = focus-column-right;
            "Mod+Shift+WheelScrollUp".action = focus-column-left;

            "Mod+1".action = focus-workspace 1;
            "Mod+2".action = focus-workspace 2;
            "Mod+3".action = focus-workspace 3;
            "Mod+4".action = focus-workspace 4;
            "Mod+5".action = focus-workspace 5;
            "Mod+6".action = focus-workspace 6;
            "Mod+7".action = focus-workspace 7;
            "Mod+8".action = focus-workspace 8;
            "Mod+9".action = focus-workspace 9;

            "Mod+Ctrl+Left".action = move-column-left;
            "Mod+Ctrl+Right".action = move-column-right;
            "Mod+Ctrl+H".action = move-column-left;
            "Mod+Ctrl+L".action = move-column-right;
            "Mod+Ctrl+Home".action = move-column-to-first;
            "Mod+Ctrl+End".action = move-column-to-last;

            "Mod+Ctrl+Down".action = move-window-down;
            "Mod+Ctrl+Up".action = move-window-up;
            "Mod+Ctrl+J".action = move-window-down;
            "Mod+Ctrl+K".action = move-window-up;

            "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
            "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
            "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
            "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
            "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
            "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
            "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
            "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

            "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
            "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
            "Mod+Ctrl+U".action = move-column-to-workspace-down;
            "Mod+Ctrl+I".action = move-column-to-workspace-up;

            "Mod+Ctrl+WheelScrollDown".action = move-column-to-workspace-down;
            "Mod+Ctrl+WheelScrollUp".action = move-column-to-workspace-up;
            "Mod+Ctrl+WheelScrollRight".action = move-column-right;
            "Mod+Ctrl+WheelScrollLeft".action = move-column-left;
            "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
            "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;

            "Mod+Shift+Page_Down".action = move-workspace-down;
            "Mod+Shift+Page_Up".action = move-workspace-up;
            "Mod+Shift+U".action = move-workspace-down;
            "Mod+Shift+I".action = move-workspace-up;

            "Mod+Shift+1".action = move-column-to-workspace 1;
            "Mod+Shift+2".action = move-column-to-workspace 2;
            "Mod+Shift+3".action = move-column-to-workspace 3;
            "Mod+Shift+4".action = move-column-to-workspace 4;
            "Mod+Shift+5".action = move-column-to-workspace 5;
            "Mod+Shift+6".action = move-column-to-workspace 6;
            "Mod+Shift+7".action = move-column-to-workspace 7;
            "Mod+Shift+8".action = move-column-to-workspace 8;
            "Mod+Shift+9".action = move-column-to-workspace 9;

            "Mod+BracketLeft".action = consume-or-expel-window-left;
            "Mod+BracketRight".action = consume-or-expel-window-right;
            "Mod+Comma".action = consume-window-into-column;
            "Mod+Period".action = expel-window-from-column;

            "Mod+R".action = switch-preset-column-width;
            "Mod+Shift+R".action = switch-preset-window-height;
            "Mod+Ctrl+R".action = reset-window-height;
            "Mod+F".action = maximize-column;
            "Mod+Shift+F".action = fullscreen-window;
            "Mod+Ctrl+F".action = expand-column-to-available-width;
            "Mod+Minus".action = set-column-width "-10%";
            "Mod+Equal".action = set-column-width "+10%";
            "Mod+Shift+Minus".action = set-window-height "-10%";
            "Mod+Shift+Equal".action = set-window-height "+10%";

            "Mod+C".action = center-column;
            "Mod+Ctrl+C".action = center-visible-columns;

            "Mod+V".action = toggle-window-floating;
            "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

            "Mod+W".action = toggle-column-tabbed-display;

            "Mod+Alt+V".action =
              spawn-sh "warp-cli status | grep -q 'Connected' && warp-cli disconnect || warp-cli connect";
            "Mod+B".action = spawn-sh "${lib.getExe self'.packages.myNoctalia} ipc call bluetooth togglePanel";

          };
        };
      };
    };
}
