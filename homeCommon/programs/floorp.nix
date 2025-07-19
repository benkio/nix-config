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
        vimium
        bitwarden
        grammarly
        xbrowsersync
        ublock-origin
        darkreader
      ];
      search = {
        force = true;
        default = "searx";
        order = [
          "searx"
          "google"
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
                template = "https://tpbay.site/search.php";
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
            name = "JobSearchEngine";
            toolbar = false;
            bookmarks = [

              {
                name = "LinkedIn";
                url = "https://www.linkedin.com/";
              }

              {
                name = "AngelList - Where the world meets startups";
                url = "https://angel.co/?ref=nav";
              }

              {
                name = "IT jobs | Permanent & contract IT careers | The UK IT Jobs Board at CWJobs.co.uk";
                url = "https://www.cwjobs.co.uk/";
              }

              {
                name = "Jobs and Recruitment on reed.co.uk, the UK's #1 job site";
                url = "https://www.reed.co.uk/";
              }

              {
                name = "Remote Scala Jobs";
                url = "https://remoteok.io/remote-scala-jobs";
              }

              {
                name = "Remote Scala Jobs | Working Nomads";
                url = "https://www.workingnomads.co/remote-scala-jobs";
              }

            ];
          }

          {
            name = "47Deg";
            toolbar = false;
            bookmarks = [

              {
                name = "Timesheet – 47 Degrees – Harvest";
                url = "https://47deg.harvestapp.com/time";
              }

              {
                name = "1-on-1s · 15Five";
                url = "https://47degrees.15five.com/one-on-one/user/";
              }

              {
                name = "Expensify - Inbox";
                url = "https://www.expensify.com/inbox";
              }

              {
                name = "clickup | 47 Degrees";
                url = "https://app.clickup.com/2338373/home";
              }

              {
                name = "Slack";
                url = "https://fortyseven.slack.com/ssb/redirect";
              }

              {
                name = "Home | 47 Degrees";
                url = "https://app.clickup.com/2338373/home";
              }

            ];
          }

          {
            name = "Social";
            toolbar = true;
            bookmarks = [

              {
                name = "Twitter";
                url = "http://twitter.com/";
              }

              {
                name = "Youtube";
                url = "http://www.youtube.com/feed/subscriptions";
              }

              {
                name = "Instagram";
                url = "https://www.instagram.com/";
              }

              {
                name = "Reddit";
                url = "https://www.reddit.com/";
              }

              {
                name = "Twitch";
                url = "https://www.twitch.tv/";
              }

            ];
          }

          {
            name = "E-Commerce";
            toolbar = true;
            bookmarks = [

              {
                name = "Amazon";
                url = "http://www.amazon.it/";
              }

              {
                name = "EBay";
                url = "http://www.ebay.it/";
              }

              {
                name = "AliExpress.com";
                url = "http://it.aliexpress.com/";
              }

            ];
          }

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
                name = "Album in Uscita";
                url = "http://metalitalia.com/articolo/gli-album-in-uscita/";
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

            ];
          }

          {
            name = "Downloads";
            toolbar = true;
            bookmarks = [
            ];
          }

          {
            name = "Torrent";
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
                url = "https://tpbay.site";
              }

            ];
          }

          {
            name = "Others";
            toolbar = true;
            bookmarks = [
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

            ];
          }

          {
            name = "Educational";
            toolbar = true;
            bookmarks = [

              {
                name = "Stepik";
                url = "https://stepik.org/lesson/186361/step/1?unit=160896";
              }

              {
                name = "Developer-Y/cs-video-courses: List of Computer Science courses with video lectures.";
                url = "https://github.com/Developer-Y/cs-video-courses#computational-finance";
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
                name = "OCaml Course";
                url = "https://www.france-universite-numerique-mooc.fr/courses/parisdiderot/56002/session01/about";
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
                name = "WordReference.com";
                url = "http://www.wordreference.com/it/";
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
                name = "Mega";
                url = "http://mega.nz/";
              }

              {
                name = "flat.io - Online Music Location";
                url = "https://flat.io/";
              }

              {
                name = "Hacklily - Lilipond Editor";
                url = "https://www.hacklily.org/";
              }

              {
                name = "Dropbox";
                url = "https://www.dropbox.com/home";
              }

              {
                name = "Google Drive";
                url = "https://drive.google.com/?tab=wo&authuser=0";
              }

              {
                name = "Google Keep";
                url = "https://drive.google.com/keep/";
              }

              {
                name = "Overleaf: Real-time Collaborative Writing and Publishing Tools with Integrated PDF Preview";
                url = "https://www.overleaf.com/";
              }

              {
                name = "TgStorage";
                url = "https://tgstorage.com/app";
              }

              {
                name = "Gmaps";
                url = "https://www.google.com/maps";
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
