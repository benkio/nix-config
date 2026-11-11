{ inputs, pkgs, ... }:

{
  programs.abcde = {
    enable = true;
    package = inputs.abcde.packages.${pkgs.stdenv.hostPlatform.system}.default;
    # Pass the device at runtime if needed, e.g. `abcde -d /dev/sr0`.
    settings = {
      OUTPUTTYPE = "flac,m4a,mp3";
      ACTIONS = "cddb,read,getalbumart,encode,tag,embedalbumart,move,clean";
      CDPARANOIAOPTS = "--never-skip=40";
      CDDBMETHOD = "cddb";
      CDDBURL = "http://gnudb.gnudb.org/~cddb/cddb.cgi";
      GLYRCOPTS = "--parallel 6";
      FLACOPTS = "-s -e -V -8";
      AACENCODERSYNTAX = "ffmpeg";
      FFMPEGENCOPTS = "-c:a aac -q:a 2";
      MP3ENCODERSYNTAX = "lame";
      LAMEOPTS = "-V 0 --vbr-new";
      MAXPROCS = 2;
      PADTRACKS = true;
    };
    # Raw shell: values here need variable expansion.
    extraConfig = ''
      OUTPUTDIR="$HOME/Music/CDRips"
      OUTPUTFORMAT='$OUTPUT/$ARTISTFILE/$ALBUMFILE/$TRACKNUM. $TRACKFILE'
      VAOUTPUTFORMAT='$OUTPUT/$ALBUMFILE/$TRACKNUM. $ARTISTFILE - $TRACKFILE'

      mungefilename ()
      {
        echo "$@" | sed -e 's/^\.*//' | tr -d ":><|*/\"'?[:cntrl:]"
      }
    '';
  };
}
