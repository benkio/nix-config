{
  cddiscid,
  cdparanoia,
  eyed3,
  fetchFromGitHub,
  ffmpeg-full,
  flac,
  glyr,
  id3v2,
  imagemagick,
  installShellFiles,
  lame,
  lib,
  makeWrapper,
  stdenvNoCC,
  vorbis-tools,
  wget,
}:

stdenvNoCC.mkDerivation rec {
  pname = "abcde";
  version = "2.13.2";

  src = fetchFromGitHub {
    owner = "poddmo";
    repo = "abcde";
    rev = version;
    hash = "sha256-5l9eAIGFCt0mhKvltOOWVeCCf7Xk/A0eHoTPr0/ZS7Y=";
  };

  nativeBuildInputs = [
    installShellFiles
    makeWrapper
  ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 abcde $out/bin/abcde
    install -Dm755 cddb-tool $out/bin/cddb-tool
    install -Dm755 abcde-musicbrainz-tool $out/bin/abcde-musicbrainz-tool

    installManPage abcde.1 cddb-tool.1
    install -Dm644 abcde.conf $out/etc/abcde.conf
    install -Dm644 README $out/share/doc/${pname}/README
    install -Dm644 FAQ $out/share/doc/${pname}/FAQ
    install -Dm644 changelog $out/share/doc/${pname}/changelog
    install -Dm644 COPYING $out/share/doc/${pname}/COPYING

    # Ensure abcde can find required tooling without global PATH assumptions.
    runtime_path='${
      lib.makeBinPath [
        cddiscid
        cdparanoia
        eyed3
        ffmpeg-full
        flac
        glyr
        id3v2
        imagemagick
        lame
        vorbis-tools
        wget
      ]
    }'

    wrapProgram $out/bin/abcde --prefix PATH : "$runtime_path"
    wrapProgram $out/bin/cddb-tool --prefix PATH : "$runtime_path"
    wrapProgram $out/bin/abcde-musicbrainz-tool --prefix PATH : "$runtime_path"

    runHook postInstall
  '';

  meta = {
    description = "A Better CD Encoder from poddmo's maintained source fork";
    homepage = "https://github.com/poddmo/abcde";
    license = lib.licenses.gpl2Plus;
    platforms = lib.platforms.unix;
    mainProgram = "abcde";
  };
}
