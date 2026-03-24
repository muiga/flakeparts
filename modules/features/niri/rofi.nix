{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      catppuccin-rofi = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "rofi";
        rev = "HEAD";
        sha256 = "sha256-81eeFjwM/haPjIEWkZPp1JSDwhWbWDAuKtWiCg7P9Q0=";
      };
    in
    {
      packages.myRofi = inputs.wrapper-modules.wrappers.rofi.wrap {
        inherit pkgs;
        settings = {
          configRasi = ''
            configuration {
              modi: "drun,run,window";
              show-icons: true;
              display-drun: "Apps:";
              display-window: "Windows:";
              drun-display-format: "{name}";
              font: "JetBrainsMono Nerd Font 11";
            }
            @import "${catppuccin-rofi}/themes/catppuccin-mocha.rasi"
            @import "${catppuccin-rofi}/catppuccin-default.rasi"
            window {
              width: 40%;
              border-radius: 12px;
              border-color: @mauve;
            }
            listview {
              spacing: 5px;
              lines: 12;
            }
            element {
              padding: 3px;
            }
            inputbar {
              padding: 5px;
              spacing: 5px;
            }
            mainbox {
              padding: 3px;
            }
            scrollbar {
              handle-color: @mauve;
            }
            element selected.normal {
              background-color: @mauve;
            }
          '';
        };
      };
    };
}
