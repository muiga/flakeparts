{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.myZenBrowser = inputs.wrapper-modules.wrappers.zen-browser.wrap {
        inherit pkgs;
        settings = {
          enable = true;

          policies = {
            AutofillAddressEnabled = true;
            AutofillCreditCardEnabled = false;
            DisableAppUpdate = true;
            DisableFeedbackCommands = true;
            DisableFirefoxStudies = true;
            DisablePocket = true;
            DisableTelemetry = true;
            DontCheckDefaultBrowser = true;
            NoDefaultBookmarks = true;
            OfferToSaveLogins = false;

            EnableTrackingProtection = {
              Value = true;
              Locked = true;
              Cryptomining = true;
              Fingerprinting = true;
            };

            ExtensionSettings = {
              "wappalyzer@crunchlabz.com" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/file/4482384/wappalyzer-6.10.83.xpi";
                installation_mode = "force_installed";
              };
              "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/file/4156831/github_file_icons-1.5.1.xpi";
                installation_mode = "force_installed";
              };
            };

            Preferences =
              let
                locked = value: {
                  "Value" = value;
                  "Status" = "locked";
                };
              in
              {
                "browser.tabs.warnOnClose" = locked false;
              };
          };
        };
      };
    };
}
