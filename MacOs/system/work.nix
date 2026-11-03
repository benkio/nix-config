{
  config,
  pkgs,
  lib,
  ...
}:

let
  workSopsFile = ../../secrets/work.yaml;
  hasWorkSecrets = builtins.pathExists workSopsFile;
in
{
  sops = lib.mkIf (config.benkio.features.enableWorkProfile && hasWorkSecrets) {
    defaultSopsFile = workSopsFile;
    age.keyFile = "/Users/${config.system.primaryUser}/.config/sops/age/keys.txt";
    secrets.work_organization = { };
    templates."work-organization".content = "${config.sops.placeholder.work_organization}";
  };

  # Work Related Packages
  environment.systemPackages =
    if config.benkio.features.enableWorkProfile then
      (with pkgs; [
        (google-cloud-sdk.withExtraComponents (
          with google-cloud-sdk.components;
          [
            gke-gcloud-auth-plugin
          ]
        )) # Google Cloud Platform CLI SDK
        awscli2 # AWS CLI
        aws-vault # AWS Vault
        cursor-cli # AI on the terminal
        claude-agent-acp # Used to Claude ↔ Emacs Communication
        humioctl # To Connect with humio
        process-compose # docker-compose like
        pnpm # npm alternative
        skaffold # python building, pushing and deploying
        uv # pip alternative
        mongosh # mongodb CLI tool
        mongodb-tools # mongodb tools for monitoring
        compass # mongodb free tool
      ])
    else
      [ ];

  homebrew =
    if config.benkio.features.enableWorkProfile then
      {
        onActivation.extraEnv = { };
        taps = [
          "hashicorp/tap"
          "smithy-lang/tap"
        ];
        brews = [
          "hashicorp/tap/vault"
        ];
        casks = [
          "claude-code"
        ];
      }
    else
      { };

  system.activationScripts.workHomebrewFromSecret.text =
    lib.optionalString (config.benkio.features.enableWorkProfile && hasWorkSecrets)
      ''
        ORG_FILE="${config.sops.templates."work-organization".path}"
        if [ ! -f "$ORG_FILE" ]; then
          exit 0
        fi

        WORK_ORG="$(tr -d '\n' < "$ORG_FILE")"
        if [ -z "$WORK_ORG" ]; then
          exit 0
        fi

        BREW_BIN="/opt/homebrew/bin/brew"
        if [ ! -x "$BREW_BIN" ]; then
          exit 0
        fi

        run_brew() {
          /usr/bin/sudo --user=${config.homebrew.user} --set-home "$BREW_BIN" "$@"
        }

        run_brew tap "$WORK_ORG/tap" "git@github.com:$WORK_ORG/homebrew-tap.git" || true
        run_brew install "$WORK_ORG/tap/kubegen" || true
        run_brew install "$WORK_ORG/tap/awsgen" || true
        run_brew install "$WORK_ORG/tap/voltage" || true
        run_brew install "$WORK_ORG/tap/oktapus" || true
        run_brew services start "$WORK_ORG/tap/oktapus" || true
        run_brew services start "$WORK_ORG/tap/omai" || true
      '';
}
