{ pkgs, ... }:

let
  # Shared Agent Skills source pins (Cursor + OpenCode via SKILL.md format).
  sources = {
    alliumSkill = pkgs.fetchFromGitHub {
      owner = "juxt";
      repo = "allium";
      rev = "7f615cef94a189bc4153b3f510517a71220d5fe2";
      sha256 = "sha256-Du3WQ9UnOc0lzvFIfjvxzzxucSFz0d9c2EpxVzBuYa8=";
    };
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
    allium = "${sources.alliumSkill}/skills/allium";
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

  # Allium ships Anthropic-style skills. OpenCode exposes those through its
  # `skill` tool, but not as slash commands. These thin wrappers make the
  # documented /allium, /elicit, /distill, ... names appear in the command palette.
  alliumCommands = {
    allium = {
      description = "Drive the Allium loop to convergence";
      skill = "allium";
      instruction = "Drive the Allium loop to convergence for this goal:";
    };
    elicit = {
      description = "Build an Allium spec through structured elicitation";
      skill = "elicit";
      instruction = "Use structured elicitation to build or refine an Allium spec from this request:";
    };
    distill = {
      description = "Extract an Allium spec from existing code";
      skill = "distill";
      instruction = "Extract an Allium spec from this codebase area:";
    };
    propagate = {
      description = "Generate tests from an Allium spec";
      skill = "propagate";
      instruction = "Generate tests from the current Allium specification. Constraints:";
    };
    tend = {
      description = "Make targeted edits to Allium specs";
      skill = "tend";
      instruction = "Make targeted changes to the Allium specs for this request:";
    };
    weed = {
      description = "Find and fix spec/code drift";
      skill = "weed";
      instruction = "Find and reconcile divergences between Allium specs and the implementation. Focus:";
    };
    witness = {
      description = "Independently verify a convergence claim";
      skill = "witness";
      instruction = "Independently witness the convergence claim for this work:";
    };
  };

  alliumCommandFiles = builtins.listToAttrs (
    builtins.attrValues (
      builtins.mapAttrs (name: command: {
        name = ".config/opencode/commands/${name}.md";
        value = {
          text = ''
            ---
            description: ${command.description}
            ---

            Load the `${command.skill}` skill with the `skill` tool before responding. ${command.instruction}

            $ARGUMENTS
          '';
        };
      }) alliumCommands
    )
  );
in
{
  home.file =
    (builtins.listToAttrs (
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
    ))
    // alliumCommandFiles;
}
