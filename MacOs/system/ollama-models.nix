{ config, pkgs, ... }:

let
  home = "/Users/benkio";
  # Import the common script from systemCommon
  ollamaModelsScript = import ../../systemCommon/ollama-models-script.nix { inherit pkgs; };
in
{
  launchd.user.agents.ollama-models = {
    serviceConfig = {
      ProgramArguments = [
        "/bin/bash"
        "-c"
        "sleep 10 && ${ollamaModelsScript}"
      ];
      RunAtLoad = true; # Run once after login with a 10 second delay
      StartInterval = 3600; # Also check every hour as a backup
      StandardErrorPath = "${home}/ollama-models.error.log";
      StandardOutPath = "${home}/ollama-models.log";
    };
  };
}
