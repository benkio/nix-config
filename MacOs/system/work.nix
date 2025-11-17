{ config, pkgs, ... }:

{
  # Work Related Packages
  environment.systemPackages = with pkgs; [
    (google-cloud-sdk.withExtraComponents (
      with google-cloud-sdk.components;
      [
        gke-gcloud-auth-plugin
      ]
    )) # Google Cloud Platform CLI SDK
    postman # HTTP Client
    process-compose # docker-compose like
    pnpm # npm alternative
    skaffold # python building, pushing and deploying
    uv # pip alternative
  ];

  homebrew = {
    taps = [
      # commercetools tap doesn't seems to work really well from here. Fallback to manual installation
      {
        name = "commercetools/tap";
        clone_target = "git@github.com:commercetools/homebrew-tap.git";
        force_auto_update = true;
      }
      "hashicorp/tap"
    ];
    brews = [
      "commercetools/tap/kubegen"
      "hashicorp/tap/vault"
    ];
  };
}
