{ config, pkgs, ... }:

let
  home = "/Users/benkio";
  # Import shared Ollama configuration
  ollamaConfig = import ../../systemCommon/ollama-config.nix;
  # Import the common script from systemCommon with the shared model
  ollamaModelsScript = import ../../systemCommon/ollama-models-script.nix {
    inherit pkgs;
    defaultModel = ollamaConfig.defaultModel;
  };
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
