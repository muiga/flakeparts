# { inputs, ... }:
# {
#   flake.nixosModules.zen-browser =
#     { pkgs, ... }:
#     let
#       system = pkgs.stdenv.hostPlatform.system;

#       mkLatestExtension = slug: {
#         install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${slug}/latest.xpi";
#         installation_mode = "force_installed";
#       };

#       lockedPref = value: {
#         Value = value;
#         Status = "locked";
#       };

#       zen-browser = inputs.zen-browser.packages.${system}.beta-unwrapped.override {
#         icon = "zen-browser"; # matches what the "default"/"beta" package normally sets
#         policies = {
#           AutofillAddressEnabled = true;
#           AutofillCreditCardEnabled = false;
#           DisableAppUpdate = true;
#           DisableFeedbackCommands = true;
#           DisableFirefoxStudies = true;
#           DisablePocket = true;
#           DisableTelemetry = true;
#           DontCheckDefaultBrowser = true;
#           NoDefaultBookmarks = true;
#           OfferToSaveLogins = false;

#           EnableTrackingProtection = {
#             Value = true;
#             Locked = true;
#             Cryptomining = true;
#             Fingerprinting = true;
#           };

#           ExtensionSettings = {
#             "uBlock0@raymondhill.net" = mkLatestExtension "ublock-origin";
#             "{6AC85730-7D0F-4de0-B3FA-21142DD85326}" = mkLatestExtension "colorzilla";
#             "{446900e4-71c2-419f-a6a7-df9c091e268b}" = mkLatestExtension "bitwarden-password-manager";
#             "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = mkLatestExtension "github-file-icons";
#           };

#           Preferences = {
#             "browser.tabs.warnOnClose" = lockedPref false;
#           };
#         };
#       };
#     in
#     {
#       environment.systemPackages = [ zen-browser ];
#     };
# }
{ inputs, ... }:
{
  flake.nixosModules.zen-browser =
    { pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    {
      environment.systemPackages = [ inputs.zen-browser.packages.${system}.beta ];
    };
}
