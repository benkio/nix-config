{
  config,
  pkgs,
  lib,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;

  fonts.fontconfig.enable = true;

  home = {
    homeDirectory = if pkgs.stdenv.hostPlatform.isDarwin then "/Users/benkio" else "/home/benkio";
    keyboard.layout = "us";
    keyboard.variant = "dvorak";
    sessionVariables = {
      LANG = "en_US.utf-8";
      SBT_NATIVE_CLIENT = "true";
      PGDATA = "${config.home.homeDirectory}/postgresDataDir";
      XDG_CURRENT_DESKTOP = "GNOME"; # To trick some app to work on i3 alone, eg gnome-control-center
    };
    stateVersion = "26.05";
    username = "benkio";
    file = {
      ".ghci".text = ''
        :set prompt "\ESC[38;5;208m\STXλ>\ESC[m\STX "

        :def hoogle \s -> return $ ":! hoogle --count=15 \"" ++ s ++ "\""
        -- Better errors
        :set -ferror-spans -freverse-errors -fprint-expanded-synonyms
      '';

      # Aspell config
      ".aspell.conf".text = "data-dir ${config.home.homeDirectory}/.nix-profile/lib/aspell";
      ".abcde.conf".text = ''
        # abcde user configuration
        # Keep CDROM unset for cross-platform use (macOS + NixOS).
        # Pass device at runtime, e.g. `abcde -d /dev/rdisk2` or `abcde -d /dev/sr0`.

        OUTPUTTYPE="flac,m4a,mp3"
        ACTIONS=cddb,read,getalbumart,encode,tag,embedalbumart,move,clean

        OUTPUTDIR="$HOME/Music/CDRips"
        OUTPUTFORMAT='$OUTPUT/$ARTISTFILE/$ALBUMFILE/$TRACKNUM. $TRACKFILE'
        VAOUTPUTFORMAT='$OUTPUT/$ALBUMFILE/$TRACKNUM. $ARTISTFILE - $TRACKFILE'

        CDROMREADERSYNTAX=cdparanoia
        CDPARANOIA=cdparanoia
        CDPARANOIAOPTS="--never-skip=40"
        CDDISCID=cd-discid

        CDDBMETHOD=cddb
        CDDBURL="http://gnudb.gnudb.org/~cddb/cddb.cgi"
        GLYRCOPTS="--parallel 6"

        FLACENCODERSYNTAX=flac
        FLAC=flac
        FLACOPTS='-s -e -V -8'

        AACENCODERSYNTAX=ffmpeg
        FFMPEGENCOPTS='-c:a aac -q:a 2'

        MP3ENCODERSYNTAX=lame
        LAME=lame
        LAMEOPTS='-V 0 --vbr-new'

        MAXPROCS=2
        PADTRACKS=y

        mungefilename ()
        {
          echo "$@" | sed -e 's/^\.*//' | tr -d ":><|*/\"'?[:cntrl:]"
        }
      '';
    };
  };
}
