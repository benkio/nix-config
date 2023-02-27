{ stdenv, fetchurl, lib }:

let
  version = "4.1.0";
  revealSrc = fetchurl {
    url = "https://github.com/hakimel/reveal.js/archive/${version}.tar.gz";
    sha256 = "sha256-KcW5TSM+sGBSU8gbdT7qCKMbw1ZJ/8zL4ec4cqf5Yy8=";
  };
in

stdenv.mkDerivation {
  name = "revealjs-${version}";
  src = revealSrc;
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/share/reveal.js/
    tar xzf $src -C $out/share/reveal.js/ --strip-components=1
    mkdir -p $out/bin/
    ln -s $out/share/reveal.js/js/reveal.js $out/bin/
    chmod +x $out/share/reveal.js/js/reveal.js
  '';
  meta = {
    description = "reveal.js is an open source HTML presentation framework";
    homepage = "https://github.com/hakimel/reveal.js";
    license = lib.licenses.mit;
  };
}
