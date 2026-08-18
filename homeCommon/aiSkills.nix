{ pkgs, ... }:

let
  # Shared Agent Skills source pins (Cursor + OpenCode via SKILL.md format).
  sources = {
    scalaSkill = pkgs.fetchFromGitHub {
      owner = "VirtusLab";
      repo = "scala-skill";
      rev = "51eb40a55fa1c2a4c99f2980830d28bbea4a2ac7";
      sha256 = "sha256-HuI7Jg1xO6ulpAUo7ObF2LmBFEpLJORvwZflwQzEX+8=";
    };
    effectTsSkill = pkgs.fetchFromGitHub {
      owner = "tenequm";
      repo = "skills";
      rev = "a64cf91e8fad60fa231a2d484f7c021b100d3127";
      sha256 = "sha256-+8/lA6wD/FKgt7LEX9ixxzs6fux20JJQhPm1t5x3Dc4=";
    };
    fpTsSkill = pkgs.fetchFromGitHub {
      owner = "whatiskadudoing";
      repo = "fp-ts-skills";
      rev = "b1c9eb70fc48aec470a98b3436d5fda4b338df3c";
      sha256 = "sha256-ge5T+/9hDK71LDlcrz8PaDsWfdRLdj+ZDchZIcovsPY=";
    };
    haskellSkill = pkgs.fetchFromGitHub {
      owner = "aiskillstore";
      repo = "marketplace";
      rev = "b1cc8fa5414840335cbed43082309fd32a013145";
      sha256 = "sha256-N9JuN906SKHf2WaiGGdSbxx8K+g1rqgbZ6Codn2mEuw=";
    };
  };

  skills = {
    direct-style-scala = "${sources.scalaSkill}/direct-style-scala/skills/direct-style-scala";
    effect-ts = "${sources.effectTsSkill}/skills/effect-ts";
    fp-pragmatic = "${sources.fpTsSkill}/skills/fp-pragmatic";
    haskell-pro = "${sources.haskellSkill}/skills/sickn33/haskell-pro";
  };

  installRoots = [
    ".agents/skills"
    ".cursor/skills"
    ".config/opencode/skills"
  ];
in
{
  home.file =
    builtins.listToAttrs (
      builtins.concatMap (
        root:
        builtins.attrValues (
          builtins.mapAttrs (skillName: sourcePath: {
            name = "${root}/${skillName}";
            value = {
              source = sourcePath;
              recursive = true;
            };
          }) skills
        )
      ) installRoots
    );
}
