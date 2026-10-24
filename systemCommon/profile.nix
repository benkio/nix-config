{ lib, config, ... }:

let
  cfg = config.benkio;
in
{
  options.benkio = {
    profile = lib.mkOption {
      type = lib.types.enum [
        "personal"
        "work"
        "ci"
      ];
      default = "personal";
      description = "High-level profile used to toggle sensitive or work-only features.";
    };

    features = {
      enableAutoLogin = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable graphical autologin on desktop systems.";
      };
      enableLocalDatabases = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable local MySQL/PostgreSQL services for development.";
      };
      enableTrustAuthForLocalPostgres = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Use trust auth locally for PostgreSQL.";
      };
      enableInsecureBootstrapPassword = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Set a known initial password-like value for bootstrap only.";
      };
      enableWorkProfile = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable work-only packages, taps, and tooling.";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf (cfg.profile == "work") {
      benkio.features.enableWorkProfile = lib.mkDefault true;
    })
    (lib.mkIf (cfg.profile == "ci") {
      benkio.features.enableLocalDatabases = lib.mkDefault false;
      benkio.features.enableAutoLogin = lib.mkDefault false;
      benkio.features.enableWorkProfile = lib.mkDefault false;
    })
  ];
}
