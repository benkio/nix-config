{
  config,
  pkgs,
  lib,
  ...
}:

{

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
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
                name = "Spirit of Metal";
                url = "http://www.spirit-of-metal.com/";
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
                name = "Free Online Tools For Developers";
                url = "http://codebeautify.org/";
              }

              {
                name = "DevDocs - Multi language documentation search engine";
                url = "https://devdocs.io/";
              }

              {
                name = "HackerRank";
                url = "https://www.hackerrank.com/";
              }

              {
                name = "exercism.io";
                url = "http://exercism.io/";
              }

              {
                name = "Excuses For Lazy Coders";
                url = "http://programmerexcuses.com/";
              }

              {
                name = "free-programming-books";
                url = "https://github.com/vhf/free-programming-books/blob/master/free-programming-books.md";
              }

              {
                name = "Internet Speed Test | Fast.com";
                url = "https://fast.com/";
              }

              {
                name = "Nix Versioning - Super useful to install the specific version you need";
                url = "https://lazamar.co.uk/nix-versions/";
              }

              { 
                name = "haskell mooc course";
                url = "https://haskell.mooc.fi/";
              }
            ];
          }

          {
            name = "Downloads";
            toolbar = true;
            bookmarks = [
              {
                name = "Rock Torrents";
                url = "http://rocktorrents.ucoz.org/load/";
              }

              {
                name = "RockBox - Index";
                url = "https://rawkbawx.rocks/";
              }

              {
                name = "Metal Torrent Tracker";
                url = "http://en.metal-tracker.com/";
              }

              {
                name = "Pirate Bay";
                url = "https://unblocked.knaben.info/thepiratebay.php";
              }

              {
                name = "xdcc.eu";
                url = "https://www.xdcc.eu";
              }

              {
                name = "StreamingCommunity";
                url = "https://streamingcommunity.cz/";
              }

              {
                name = "Anna’s Archive";
                url = "https://it.annas-archive.org/";
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
                name = "Developer-Y/cs-video-courses: List of Computer Science courses with video lectures.";
                url = "https://github.com/Developer-Y/cs-video-courses";
              }

              {
                name = "edX | Free online courses from the world's best universities";
                url = "https://www.edx.org/";
              }

              {
                name = "Coursera";
                url = "https://www.coursera.org/";
              }

              {
                name = "Udemy";
                url = "https://www.udemy.com/jazz-guitar-tips-tricks-and-licks/";
              }

              {
                name = "RandomWiki";
                url = "https://en.wikipedia.org/wiki/Special:Random";
              }

              {
                name = "The Flowchart - UKPersonalFinance Wiki";
                url = "https://ukpersonal.finance/flowchart/";
              }

            ];
          }

          {
            name = "Cloud Storage & Collab. Tools";
            toolbar = true;
            bookmarks = [

              {
                name = "flat.io - Online Music Location";
                url = "https://flat.io/";
              }

              {
                name = "Hacklily - Lilipond Editor";
                url = "https://www.hacklily.org/";
              }

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
        ];
      };
    };
  };
}
