{
  config,
  pkgs,
  lib,
  ...
}:

let
  nur =
    import
      (builtins.fetchGit {
        url = "https://github.com/nix-community/NUR";
        rev = "fb993e86121b76faf5dde868a2b8e2390e4035ca";
      })
      {
        nurpkgs = pkgs;
        pkgs = pkgs;
      };
in
{

  nixpkgs.config.packageOverrides = pkgs: {
    inherit nur;
  };

  programs.floorp = {
    enable = true;
    profiles.benkio = {
      id = 0;
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        darkreader
        grammarly
        ublock-origin
        vimium
        proton-vpn
      ];
      search = {
        force = true;
        default = "google";
        order = [
          "google"
          "searx"
        ];
        engines = {
          google.metaData.alias = "@g";
          youtube = {
            name = "Youtube";
            urls = [
              {
                template = "https://www.youtube.com/results";
                params = [
                  {
                    name = "search_query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [ "@yt" ];
          };
          nix-packages = {
            name = "Nix Packages";
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          hoogle = {
            name = "Hoogle";
            urls = [
              {
                template = "https://hoogle.haskell.org/";
                params = [
                  {
                    name = "hoogle";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [ "@hg" ];
          };
          searx = {
            name = "Searx";
            urls = [
              {
                template = "https://priv.au/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
              {
                template = "https://search.inetol.net/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
              {
                template = "https://search.hbubli.cc/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
              {
                template = "https://search.rhscz.eu/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [ "@sx" ];
          };
          invidious = {
            name = "Invidious";
            urls = [
              {
                template = "https://yewtu.be/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
              {
                template = "https://inv.nadeko.net/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
              {
                template = "https://id.420129.xyz/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [ "@iv" ];
          };
          piratebay = {
            name = "Pirate Bay";
            urls = [
              {
                template = "https://unblocked.knaben.info/thepiratebay.php";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [ "@pb" ];
          };
          wikipedia = {
            name = "Wikipedia";
            urls = [
              {
                template = "https://en.wikipedia.org/w/index.php";
                params = [
                  {
                    name = "search";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [ "@wiki" ];
          };
        };
      };
      bookmarks = {
        force = true;
        settings = [

          {
            name = "Music";
            toolbar = true;
            bookmarks = [

              {
                name = "Hacklily - Lilipond Editor";
                url = "https://www.hacklily.org/";
              }

              {
                name = "Pitch and Speed (Tempo) converter";
                url = "http://www.conversion-tool.com/pitch";
              }

              {
                name = "Transposr.com";
                url = "https://transposr.com/songs/new";
              }

              {
                name = "Metronome";
                url = "https://www.virtualsheetmusic.com/metronome/";
              }

              {
                name = "Guitar Tuner";
                url = "https://yousician.com/guitartuna";
              }

              {
                name = "LALAL.AI";
                url = "https://www.lalal.ai/";
              }

              {
                name = "FastStrings";
                url = "http://faststrings.com/";
              }

              {
                name = "Guitar Interactive - The Worlds' No.1 Free Digital Guitar Magazine";
                url = "https://www.guitarinteractivemagazine.com/";
              }

              {
                name = "Every Noise at Once - Music Genres Organized";
                url = "https://everynoise.com/engenremap.html";
              }

              {
                name = "Music Map - Discover Music Through Similar Artist";
                url = "https://www.music-map.com/";
              }
            ];
          }

          {
            name = "Dev Tools";
            toolbar = true;
            bookmarks = [

              {
                name = "Hyperpolyglot";
                url = "http://hyperpolyglot.org/";
              }

              {
                name = "DevDocs - Multi language documentation search engine";
                url = "https://devdocs.io/";
              }

              {
                name = "Excuses For Lazy Coders";
                url = "http://programmerexcuses.com/";
              }

              {
                name = "Internet Speed Test | Fast.com";
                url = "https://fast.com/";
              }

              {
                name = "Nix Versioning - Super useful to install the specific version you need";
                url = "https://lazamar.co.uk/nix-versions/";
              }
            ];
          }

          {
            name = "Downloads";
            toolbar = true;
            bookmarks = [

              {
                name = "Pirate Bay";
                url = "https://unblocked.knaben.info/thepiratebay.php";
              }

              {
                name = "xdcc.eu";
                url = "https://www.xdcc.eu";
              }

              {
                name = "Shadow Libraries";
                url = "https://shadowlibraries.github.io/";
              }

              {
                name = "FMHY - freemediaheckyeah The largest collection of free stuff on the internet!";
                url = "https://fmhy.net/";
              }
            ];
          }

          {
            name = "Educational";
            toolbar = true;
            bookmarks = [

              {
                name = "Wiki Gatcha - Wikipedia Pokemon Cards";
                url = "https://wikigacha.com";
              }
            ];
          }

          {
            name = "Cloud Storage";
            toolbar = true;
            bookmarks = [

              {
                name = "TgStorage";
                url = "https://tgstorage.com/app";
              }

              {
                name = "FreshRSS";
                url = "https://reader.websitemachine.nl/i/#close";
              }

              {
                name = "Organice";
                url = "https://organice.200ok.ch/files";
              }
            ];
          }

          {
            name = "Japanese";
            toolbar = true;
            bookmarks = [

              {
                name = "Jisho - Japanese Dictionary";
                url = "https://flat.io/";
              }

              {
                name = "TTSHub - Text to Speech";
                url = "https://ttshub.net/";
              }

              {
                name = "Anki Web - Space Repetition Deck Cards";
                url = "https://ankiweb.net";
              }
            ];
          }
        ];
      };
      settings = {
        "browser.startup.homepage" = "https://wikigacha.com";
        "browser.newtabpage.pinned" = [
          {
            title = "Google Calendar";
            url = "https://calendar.google.com/calendar/u/0/r/month";
          }
          {
            title = "Gmail";
            url = "https://mail.google.com/mail/u/0/#inbox";
          }
          {
            title = "Fresh RSS";
            url = "https://reader.websitemachine.nl/i/?a=normal&get=f_89";
          }
        ];
      };
    };
  };
}
