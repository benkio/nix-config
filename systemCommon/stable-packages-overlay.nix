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
  # unstable: Backend subprocess exited when trying to invoke build_wheel
  picard = stable.picard;
  # unstable: sqlfluff's diff-cover dependency currently fails its test suite
  sqlfluff = stable.sqlfluff;
  # hash mismatch for typescript-language-server 6.0.2 pnpm deps in unstable
  typescript-language-server = stable.typescript-language-server;
}
