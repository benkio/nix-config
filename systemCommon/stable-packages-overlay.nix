# Pin selected packages to nixpkgs-stable: unstable currently fails local
# Darwin links with cctools ld (Trace/BPT trap) for these dependency trees.
inputs: final: prev:
let
  stable = inputs.nixpkgs-stable.legacyPackages.${prev.stdenv.hostPlatform.system};
in
{
  # unstable: python3.14-rubicon-objc check phase
  maestral = stable.maestral;
  # unstable: whisper-cpp (ffmpeg-full dependency) link phase
  ffmpeg-full = stable.ffmpeg-full;
  # unstable: rust link phase (same cctools ld crash)
  watchexec = stable.watchexec;
}
