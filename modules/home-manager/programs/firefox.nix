{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.programs.firefox;
in
{
  options.my.programs.firefox = {
    enable = lib.mkEnableOption "firefox";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      configPath = ".mozilla/firefox";
      policies = {
        AIControls.Default = {
          Value = "blocked";
          Locked = true;
        };
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableFirefoxAccounts = true;
        DisableFirefoxScreenshots = true;
        DisableFirefoxStudies = true;
        DisableFormHistory = true;
        DisableProfileImport = true;
        DisableProfileRefresh = true;
        DisableRemoteImprovements = true;
        DisableSystemAddonUpdate = true;
        DisableTelemetry = true;
        DNSOverHTTPS = {
          Enabled = true;
          Locked = true;
        };
        EnableTrackingProtection = {
          Category = "strict";
          Locked = true;
        };
        EncryptedMediaExtensions = {
          Enabled = false;
          Locked = true;
        };
        FirefoxHome = {
          Search = false;
          TopSites = false;
          SponsoredTopSites = false;
          Highlights = false;
          Stories = false;
          SponsoredStories = false;
          Locked = true;
        };
        Homepage = {
          URL = "about:home";
          StartPage = "homepage-locked";
          Locked = true;
        };
        HttpsOnlyMode = "force_enabled";
        NewTabPage = true;
        PasswordManagerEnabled = false;
        PrimaryPassword = false;
        SanitizeOnShutdown = true;
        SearchSuggestEnabled = false;
        UserMessaging = {
          MoreFromMozilla = false;
          FirefoxLabs = false;
          Locked = true;
        };
        VisualSearchEnabled = false;
        ExtensionSettings = {
          "*".installation_mode = "blocked";
          "uBlock0@raymondhill.net" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/uBlock0@raymondhill.net/latest.xpi";
            default_area = "menupanel";
            private_browsing = true;
          };
        };
      };
      profiles.default = {
        search = {
          default = "ddg";
          force = true;
        };
        settings = {
          "browser.urlbar.showSearchTerms.enabled" = false;
          "browser.urlbar.suggest.bookmark" = false;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.history" = false;
          "browser.urlbar.suggest.openpage" = false;
          "browser.urlbar.suggest.quickactions" = false;
          "browser.urlbar.suggest.recentsearches" = false;
          "browser.urlbar.suggest.topsites" = false;
        };
      };
    };
  };
}
