{ ... }: let
  name = "hervyqa";
  email = "hervyqa@proton.me";
  fullname = "Hervy Qurrotul Ainur Rozi";
  # gpg --list-secret-keys --keyid-format=long | grep sec
  signingkey = "D7B52C04D9B40738";
in {
  home-manager = {
    users.${name} = {
      programs = {
        git = {
          enable = true;
          userEmail = "${email}";
          userName = "${fullname}";
          signing = {
            signByDefault = true;
            key = "${signingkey}";
          };
          lfs = {
            enable = true;
          };
          ignores = [
            "*~"
            "*.swp"
          ];
          extraConfig = {
            init = {
              defaultBranch = "main";
            };
            pull = {
              rebase = true;
            };
            core = {
              editor = "hx";
              whitespace = "trailing-space,space-before-tab"; 
            };
            alias = {
              ad = "add";
              br = "branch";
              cm = "commit";
              co = "checkout";
              df = "diff";
              fe = "fetch";
              lg = "log";
              mr = "merge";
              pl = "pull";
              ps = "push";
              rt = "remote";
              st = "status";
              sw = "switch";
              tg = "tag";
            };
            url = {
              "git@git.sr.ht:" = {
                insteadOf = [
                  "https://git.sr.ht/"
                ];
              };
              "git@github.com:" = {
                insteadOf = [
                  "https://github.com/"
                ];
              };
              "git@gitlab.com:" = {
                insteadOf = [
                  "https://gitlab.com/"
                ];
              };
            };
          };
        };
      };
    };
  };
}
