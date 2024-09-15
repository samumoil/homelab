{
  pkgs,
  ...
}:
with pkgs;
let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        fish = {
          enable = true;
          interactiveShellInit = ''
            set fish_greeting
          '';
          plugins = with fishPlugins; [
            { name = "forgit"; src = forgit; }
            { name = "git"; src = plugin-git; }
            { name = "hydro"; src = hydro; }
            { name = "pisces"; src = pisces; }
            { name = "pure"; src = pure; }
            { name = "sponge"; src = sponge; }
            { name = "tide"; src = tide; }
          ];
          shellAbbrs = {
            e = "exa";
            b = "bat";
            d = "doas";
            h = "hx";
            g = "git";
            f = "fastfetch";
            t = "btm";
            q = "quarto";
            j = "joshuto";
            c = "cp";
            m = "mv";
            y = "yazi";

            tg = "tgpt -q";
            tt = "tgpt -c";

            bb = "btm -b";
            cp = "cp -rfv";
            cv = "cava";
            ds = "du -sh";
            ht = "htop";
            lb = "lsblk -o name,fstype,fsavail,fsused,size,mountpoint";
            lg = "libgen-cli -e pdf search";
            mk = "mkdir -pv";
            mv = "mv -v";
            nc = "ncmpcpp";
            rm = "rm -rfv";

            ns = "nix-search";

            qp = "quarto preview";
            qr = "quarto render";

            yt = "yt-dlp";
            yv = "yt-dlp -f bestvideo+bestaudio";
            ym = "yt-dlp -f bestaudio -x --audio-format vorbis";

            sa = "systemctl --user start";
            so = "systemctl --user stop";
            sr = "systemctl --user restart";
            st = "systemctl --user status";

            dsa = "doas systemctl start";
            dso = "doas systemctl stop";
            dsr = "doas systemctl restart";
            dst = "doas systemctl status";

            neq = "nix-env -qaP";
            nim = "nix-shell -p nix-info --run 'nix-info -m'";

            nei = "nix-env -iA";
            neu = "nix-env --uninstall";

            nlg = "nix-env --list-generations -p /home/${name}/.local/state/nix/profiles/profile";
            hlg = "nix-env --list-generations -p /home/${name}/.local/state/nix/profiles/home-manager";
            slg = "doas nix-env --list-generations -p /nix/var/nix/profiles/system";

            ndg = "nix-env --delete-generations old -p /home/${name}/.local/state/nix/profiles/profile";
            hdg = "nix-env --delete-generations old -p /home/${name}/.local/state/nix/profiles/home-manager";
            sdg = "doas nix-env --delete-generations old -p /nix/var/nix/profiles/system";

            dncl = "doas nix-channel --list";
            dncu = "doas nix-channel --update";
            dnrd = "doas nixos-rebuild dry-build";
            dnrs = "doas nixos-rebuild switch";
            dnru = "doas nixos-rebuild switch --upgrade";
            dngc = "doas nix-store --gc";
            dngd = "doas nix-collect-garbage --delete-old";

            trab = "trans :ab -b";
            tren = "trans :en -b";
            trid = "trans :id -b";
            trja = "trans :ja -b";

            gad = "git add";
            gal = "git add --all";

            gb = "git branch";
            gbl = "git blame -b -w";
            gbr = "git branch --remote";

            gcm = "git commit -S -m";
            gcam = "git commit S --amend";

            gcb = "git checkout -b";
            gck = "git checkout main";

            gcf = "git config --list";
            gcl = "git clone --recursive";
            gcln = "git clean -fd";
            gcp = "git cherry-pick";

            gdf = "git diff";
            gdca = "git diff --cached";

            gfs = "git fetch sh";
            gfg = "git fetch gh";
            gfl = "git fetch gl";
            gfa = "git fetch --all --prune";

            gignore = "git update-index --assume-unchanged";

            gls = "git log --stat";
            glsp = "git log --stat -p";
            glg = "git log --graph";
            glo = "git log --decorate --oneline";

            gm = "git merge";
            gmsm = "git merge sh/main";
            gmgm = "git merge gh/main";
            gmlm = "git merge gl/main";
            gmt = "git mergetool --no-prompt";

            gpsm = "git push -u sh main";
            gpgm = "git push -u gh main";
            gplm = "git push -u gl main";

            gr = "git remote";
            gra = "git remote add";
            grv = "git remote --verbose";

            grh = "git reset HEAD";
            grhh = "git reset HEAD --hard";

            gst = "git status -sbu";
            gsps = "git show --pretty=short --show-signature";
            gsts = "git stash show --text";
            gsu = "git submodule update";

            gts = "git tag -s";
            gta = "git tag -a";

            gur = "git pull --rebase";
            gusm = "git pull sh main";
            gugm = "git pull gh main";
            gulm = "git pull gl main";
          };
        };
      };
    };
  };
}
