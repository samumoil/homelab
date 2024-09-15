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
        helix = {
          enable = true;
          defaultEditor = true;
          settings = {
            theme = "base16_transparent";
            editor = {
              bufferline = "always";
              cursorline = true;
              cursorcolumn = true;
              line-number = "relative";
              rulers = [80];
              true-color = true;
              indent-guides = {
                render = true;
                character = "┊";
                skip-levels = 0;
              };
              lsp = {
                display-messages = true;
              };
              soft-wrap = {
                enable = false;
                max-wrap = 25;
                max-indent-retain = 0;
              };
              whitespace.render = {
                space = "all";
                tab = "all";
                newline = "none";
              };
            };
            keys = {
              normal = {
                space = {
                  W = ":toggle-option soft-wrap.enable";
                  F = ":pipe fmt -w 79";
                };
              };
              insert = {
                up = "no_op";
                down = "no_op";
                left = "no_op";
                right = "no_op";
                pageup = "no_op";
                pagedown = "no_op";
                home = "no_op";
                end = "no_op";
              };
            };
          };
          languages = {
            language = [
              {
                name = "bibtex";
                scope = "source.bib";
                injection-regex = "bib";
                file-types = [ "bib" ];
                comment-token = "%";
                language-servers = [ "texlab" ];
                indent = {
                  tab-width = 4;
                  unit = "\t";
                };
                auto-format = true;
                formatter = {
                  command = "${bibtex-tidy}/bin/bibtex-tidy";
                  args = [
                    "-"
                    "--curly"
                    "--drop-all-caps"
                    "--remove-empty-fields"
                    "--sort-fields"
                    "--sort=year,author,id"
                    "--strip-enclosing-braces"
                    "--trailing-commas"
                  ];
                };
              }
              {
                name = "c";
                scope = "source.c";
                injection-regex = "c";
                file-types = [ "c" ]; # TODO: [ "h" ];
                comment-token = "//";
                block-comment-tokens = {
                  start = "/*";
                  end = "*/";
                };
                language-servers = [ "clangd" ];
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
                debugger = {
                  name = "lldb-dap";
                  transport = "stdio";
                  command = "${lldb}/bin/lldb-vscode";
                  templates = [
                    {
                      name = "binary";
                      request = "launch";
                      completion = [
                        {
                          name = "binary";
                          completion = "filename";
                        }
                      ];
                      args = {
                        console = "internalConsole";
                        program = "{0}";
                      };
                    }
                    {
                      name = "attach";
                      request = "attach";
                      completion = [ "pid" ];
                      args = {
                        console = "internalConsole";
                        pid = "{0}";
                      };
                    }
                    {
                      name = "gdbserver attach";
                      request = "attach";
                      completion = [
                        {
                          name = "lldb connect url";
                          default = "connect://localhost:3333";
                        }
                        {
                          name = "file";
                          completion = "filename";
                        }
                        "pid"
                      ];
                      args = {
                        console = "internalConsole";
                        attachCommands = [
                          "platform select remote-gdb-server"
                          "platform connect {0}"
                          "file {1}" "attach {2}"
                        ];
                      };
                    }
                  ];
                };
              }
              {
                name = "cabal";
                scope = "source.cabal";
                file-types = [ "cabal" ];
                roots = [ "cabal.project" "Setup.hs" ];
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
                comment-token = "--";
                language-servers = [ "haskell-language-server" ];
              }
              {
                name = "cpp";
                scope = "source.cpp";
                injection-regex = "cpp";
                file-types = [
                  "cc" "hh" "c++" "cpp" "hpp" "h" "ipp" "tpp" "cxx"
                  "hxx" "ixx" "txx" "ino" "C" "H" "cu" "cuh" "cppm"
                  "h++" "ii" "inl"
                  { glob = ".hpp.in"; } { glob = ".h.in"; }
                ];
                comment-token = "//";
                block-comment-tokens = {
                  start = "/*";
                  end = "*/";
                };
                language-servers = [ "clangd" ];
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
                debugger = {
                  name = "lldb-dap";
                  transport = "stdio";
                  command = "${lldb}/bin/lldb-vscode";
                  templates = [
                    {
                      name = "binary";
                      request = "launch";
                      completion = [
                        {
                          name = "binary";
                          completion = "filename";
                        }
                      ];
                      args = {
                        console = "internalConsole";
                        program = "{0}";
                      };
                    }
                    {
                      name = "attach";
                      request = "attach";
                      completion = [ "pid" ];
                      args = {
                        console = "internalConsole";
                        pid = "{0}";
                      };
                    }
                    {
                      name = "gdbserver attach";
                      request = "attach";
                      completion = [
                        {
                          name = "lldb connect url";
                          default = "connect://localhost:3333";
                        }
                        {
                          name = "file";
                          completion = "filename";
                        }
                        "pid"
                      ];
                      args = {
                        console = "internalConsole";
                        attachCommands = [
                          "platform select remote-gdb-server"
                          "platform connect {0}"
                          "file {1}"
                          "attach {2}"
                        ];
                      };
                    }
                  ];
                };
              }
              {
                name = "clojure";
                scope = "source.clojure";
                injection-regex = "(clojure|clj|edn|boot)";
                file-types = [
                  "boot" "clj" "cljc" "clje" "cljr" "cljs" "cljx" "edn"
                ];
                roots = [
                  "project.clj" "build.boot" "deps.edn" "shadow-cljs.edn"
                ];
                comment-token = ";";
                language-servers = [ "clojure-lsp" ];
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
              }
              {
                name = "cmake";
                scope = "source.cmake";
                file-types = [
                  "cmake"
                  { glob = "CMakeLists.txt"; }
                ];
                comment-token = "#";
                block-comment-tokens = {
                  start = "#[[";
                  end = "]]";
                };
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
                language-servers = [ "cmake-language-server" ];
                injection-regex = "cmake";
              }
              {
                name = "crystal";
                scope = "source.cr";
                file-types = [ "cr" ];
                roots = [
                  "shard.yml"
                  "shard.lock"
                ];
                comment-token = "#";
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
                grammar = "ruby";
                language-servers = [ "crystalline" ];
              }
              {
                name = "css";
                scope = "source.css";
                injection-regex = "css";
                file-types = [ "css" "scss" ];
                block-comment-tokens = {
                  start = "/*";
                  end = "*/";
                };
                language-servers = [ "vscode-css-language-server" ];
                auto-format = true;
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
              }
              {
                name = "cue";
                scope = "source.cue";
                injection-regex = "cue";
                file-types = [ "cue" ];
                roots = [ "cue.mod" ];
                auto-format = true;
                comment-token = "//";
                language-servers = [ "cuelsp" ];
                indent = {
                  tab-width = 4;
                  unit = "\t";
                };
                formatter = {
                  command = "${cue}/bin/cue";
                  args = [ "fmt" "-" ];
                };
              }
              {
                name = "d";
                scope = "source.d";
                file-types = [ "d" "dd" ];
                comment-token = "//";
                block-comment-tokens = {
                  start = "/*";
                  end = "*/";
                };
                injection-regex = "d";
                indent = {
                  tab-width = 4;
                  unit = "    ";
                };
                language-servers = [ "serve-d" ];
                formatter = {
                  command = "${dfmt}/bin/dfmt";
                };
              }
              {
                name = "dockerfile";
                scope = "source.dockerfile";
                injection-regex = "docker|dockerfile";
                roots = [ "Dockerfile" "Containerfile" ];
                file-types = [
                  "Dockerfile"
                  { glob = "Dockerfile"; }
                  { glob = "Dockerfile.*"; }
                  "dockerfile"
                  { glob = "dockerfile"; }
                  { glob = "dockerfile.*"; }
                  "Containerfile"
                  { glob = "Containerfile"; }
                  { glob = "Containerfile.*"; }
                  "containerfile"
                  { glob = "containerfile"; }
                  { glob = "containerfile.*"; }
                ];
                comment-token = "#";
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
                language-servers = [ "docker-langserver" ];
              }
              {
                name = "docker-compose";
                scope = "source.yaml.docker-compose";
                roots = [
                  "docker-compose.yaml"
                  "docker-compose.yml"
                ];
                language-servers = [
                  "docker-compose-langserver"
                  "yaml-language-server"
                ];
                file-types = [
                  { glob = "docker-compose.yaml"; }
                  { glob = "docker-compose.yml"; }
                ];
                comment-token = "#";
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
              }
              {
                name = "dot";
                scope = "source.dot";
                injection-regex = "dot";
                file-types = [ "dot" ];
                comment-token = "//";
                block-comment-tokens = {
                  start = "/*";
                  end = "*/";
                };
                indent = {
                  tab-width = 4;
                  unit = "    ";
                };
                language-servers = [ "dot-language-server" ];
              }
              {
                name = "elixir";
                scope = "source.elixir";
                injection-regex = "(elixir|ex)";
                file-types = [
                  "ex" "exs"
                  { glob = "mix.lock"; }
                ];
                shebangs = [ "elixir" ];
                roots = [ "mix.exs" "mix.lock" ];
                comment-token = "#";
                language-servers = [ "elixir-ls" ];
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
              }
              {
                name = "elm";
                scope = "source.elm";
                injection-regex = "elm";
                file-types = [ "elm" ];
                roots = [ "elm.json" ];
                auto-format = true;
                comment-token = "--";
                block-comment-tokens = {
                  start = "{-";
                  end = "-}";
                };
                language-servers = [ "elm-language-server" ];
                indent = {
                  tab-width = 4;
                  unit = "    ";
                };
              }
              {
                name = "elvish";
                scope = "source.elvish";
                shebangs = [ "elvish" ];
                file-types = [ "elv" ];
                comment-token = "#";
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
                language-servers = [ "elvish" ];
                grammar = "elvish";
              }
              {
                name = "erlang";
                scope = "source.erlang";
                injection-regex = "erl(ang)?";
                file-types = [
                  "erl" "hrl" "app"
                  { glob = "rebar.config"; }
                  { glob = "rebar.lock"; }
                  { glob = "*.app.src"; }
                ];
                roots = [ "rebar.config" ];
                shebangs = [ "escript" ];
                comment-token = "%%";
                indent = {
                  tab-width = 4;
                  unit = "    ";
                };
                language-servers = [ "erlang-ls" ];
              }
              {
                name = "fish";
                scope = "source.fish";
                injection-regex = "fish";
                file-types = [ "fish" ];
                shebangs = [ "fish" ];
                comment-token = "#";
                indent = {
                  tab-width = 4;
                  unit = "    ";
                };
                auto-format = true;
                formatter = {
                  command = "${fish}/bin/fish_indent";
                };
              }
              {
                name = "gleam";
                scope = "source.gleam";
                injection-regex = "gleam";
                file-types = [ "gleam" ];
                roots = [ "gleam.toml" ];
                comment-token = "//";
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
                language-servers = [ "gleam" ];
                auto-format = true;
              }
              {
                name = "gdscript";
                scope = "source.gdscript";
                injection-regex = "gdscript";
                file-types = [ "gd" ];
                shebangs = [];
                roots = [ "project.godot" ];
                auto-format = true;
                formatter = {
                  command = "${gdtoolkit_3}/bin/gdformat";
                  args = [ "-" ];
                };
                comment-token = "#";
                indent = {
                  tab-width = 4;
                  unit = "\t";
                };
              }
              {
                name = "godot-resource";
                scope = "source.tscn";
                injection-regex = "godot";
                file-types = [ "tscn" "tres" "godot" "gdextension" ];
                shebangs = [];
                roots = [ "project.godot" ];
                auto-format = false;
                comment-token = ";";
                indent = {
                  tab-width = 4;
                  unit = "\t";
                };
              }
              {
                name = "go";
                scope = "source.go";
                injection-regex = "go";
                file-types = [ "go" ];
                roots = [ "go.work" "go.mod" ];
                auto-format = true;
                comment-token = "//";
                block-comment-tokens = {
                  start = "/*";
                  end = "*/";
                };
                language-servers = [ "gopls" "golangci-lint-lsp" ];
                indent = {
                  tab-width = 4;
                  unit = "\t";
                };
                debugger = {
                  name = "go";
                  transport = "tcp";
                  command = "${delve}/bin/dlv";
                  args = [ "dap" ];
                  port-arg = "-l 127.0.0.1:{}";
                  templates = [
                    {
                      name = "source";
                      request = "launch";
                      completion = [
                        {
                          name = "entrypoint";
                          completion = "filename";
                          default = ".";
                        }
                      ];
                      args = {
                        mode = "debug";
                        program = "{0}";
                      };
                    }
                    {
                      name = "binary";
                      request = "launch";
                      completion = [
                        {
                          name = "binary";
                          completion = "filename";
                        }
                      ];
                      args = {
                        mode = "exec";
                        program = "{0}";
                      };
                    }
                    {
                      name = "test";
                      request = "launch";
                      completion = [
                        {
                          name = "tests";
                          completion = "directory";
                          default = ".";
                        }
                      ];
                      args = {
                        mode = "test";
                        program = "{0}";
                      };
                    }
                    {
                      name = "attach";
                      request = "attach";
                      completion = [ "pid" ];
                      args = {
                        mode = "local";
                        processId = "{0}";
                      };
                    }
                    {
                      name = "core";
                      request = "launch";
                      completion = [
                        {
                          name = "binary";
                          completion = "filename";
                        }
                        {
                          name = "core";
                          completion = "filename";
                        }
                      ];
                      args = {
                        mode = "core";
                        program = "{0}";
                        coreFilePath = "{1}";
                      };
                    }
                  ];
                };
              }
              {
                name = "gomod";
                scope = "source.gomod";
                injection-regex = "gomod";
                file-types = [
                  { glob = "go.mod"; }
                ];
                auto-format = true;
                comment-token = "//";
                language-servers = [ "gopls" ];
                indent = {
                  tab-width = 4;
                  unit = "\t";
                };
              }
              {
                name = "gotmpl";
                scope = "source.gotmpl";
                injection-regex = "gotmpl";
                file-types = [ "gotmpl" ];
                comment-token = "//";
                block-comment-tokens = {
                  start = "/*";
                  end = "*/";
                };
                language-servers = [ "gopls" ];
                indent = {
                  tab-width = 2;
                  unit = " ";
                };
              }
              {
                name = "gowork";
                scope = "source.gowork";
                injection-regex = "gowork";
                file-types = [
                  { glob = "go.work"; }
                ];
                auto-format = true;
                comment-token = "//";
                language-servers = [ "gopls" ];
                indent = {
                  tab-width = 4;
                  unit = "\t";
                };
              }
              {
                name = "haskell";
                scope = "source.haskell";
                injection-regex = "hs|haskell";
                file-types = [ "hs" "hs-boot" ];
                roots = [ "Setup.hs" "stack.yaml" "cabal.project" ];
                comment-token = "--";
                block-comment-tokens = {
                  start = "{-";
                  end = "-}";
                };
                language-servers = [ "haskell-language-server" ];
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
              }
              {
                name = "haskell-persistent";
                scope = "source.persistentmodels";
                file-types = [ "persistentmodels" ];
                comment-token = "--";
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
              }
              {
                name = "helm";
                grammar = "gotmpl";
                scope = "source.helm";
                roots = [ "Chart.yaml" ];
                comment-token = "#";
                language-servers = [ "helm_ls" ];
                file-types = [
                  { glob = "templates/*.yaml"; }
                  { glob = "templates/*.yml"; }
                  { glob = "templates/_*.tpl"; }
                  { glob = "templates/NOTES.txt"; }
                ];
              }
              {
                name = "html";
                scope = "text.html.basic";
                injection-regex = "html";
                file-types = [
                  "asp" "aspx" "htm" "html" "jshtm" "jsp"
                  "rhtml" "shtml" "volt" "xht" "xhtml"
                ];
                block-comment-tokens = {
                  start = "<!--";
                  end = "-->";
                };
                language-servers = [ "vscode-html-language-server" ];
                auto-format = true;
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
              }
              {
                name = "java";
                scope = "source.java";
                injection-regex = "java";
                file-types = [ "java" "jav" "pde" ];
                roots = [ "pom.xml" "build.gradle" "build.gradle.kts" ];
                language-servers = [ "jdtls" ];
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
              }
              {
                name = "javascript";
                scope = "source.js";
                injection-regex = "(js|javascript)";
                language-id = "javascript";
                file-types = [
                  "js" "mjs" "cjs" "rules" "es6" "pac"
                  { glob = ".node_repl_history"; }
                  { glob = "jakefile"; }
                ];
                shebangs = [ "node" ];
                comment-token = "//";
                block-comment-tokens = {
                  start = "/*";
                  end = "*/";
                };
                language-servers = [ "typescript-language-server" ];
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
                debugger = {
                  name = "node-debug2";
                  transport = "stdio";
                  quirks = { absolute-paths = true; };
                  templates = [
                    {
                      name = "source";
                      request = "launch";
                      completion = [
                        {
                          name = "main";
                          completion = "filename";
                          default = "index.js";
                        }
                      ];
                      args = { program = "{0}"; };
                    }
                  ];
                };
              }
              {
                name = "julia";
                scope = "source.julia";
                injection-regex = "julia";
                file-types = [ "jl" ];
                shebangs = [ "julia" ];
                roots = [ "Manifest.toml" "Project.toml" ];
                comment-token = "#";
                block-comment-tokens = {
                  start = "#=";
                  end = "=#";
                };
                language-servers = [ "julia" ];
                indent = {
                  tab-width = 4;
                  unit = "    ";
                };
              }
              {
                name = "latex";
                scope = "source.tex";
                injection-regex = "tex";
                file-types = [ "tex" "sty" "cls" "Rd" "bbx" "cbx" ];
                comment-token = "%";
                language-servers = [ "texlab" ];
                indent = {
                  tab-width = 4;
                  unit = "\t";
                };
              }
              {
                name = "koka";
                scope = "source.koka";
                injection-regex = "koka";
                file-types = [ "kk" ];
                comment-token = "//";
                indent = {
                  tab-width = 8;
                  unit = "  ";
                };
                language-servers = [ "koka" ];
              }
              {
                name = "lean";
                scope = "source.lean";
                injection-regex = "lean";
                file-types = [ "lean" ];
                roots = [ "lakefile.lean" ];
                comment-token = "--";
                block-comment-tokens = {
                  start = "/-";
                  end = "-/";
                };
                language-servers = [ "lean" ];
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
              }
              {
                name = "lua";
                injection-regex = "lua";
                scope = "source.lua";
                file-types = [ "lua" ];
                shebangs = [ "lua" "luajit" ];
                roots = [
                  ".git"
                  ".luacheckrc"
                  ".luarc.json"
                  ".stylua.toml"
                  "selene.toml"
                ];
                comment-token = "--";
                block-comment-tokens = {
                  start = "--[[";
                  end = "--]]";
                };
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
                language-servers = [ "lua-language-server" ];
              }
              {
                name = "make";
                scope = "source.make";
                file-types = [
                  "mak" "make" "mk"
                  { glob = "GNUmakefile"; }
                  { glob = "Makefile"; }
                  { glob = "OCamlMakefile"; }
                  { glob = "makefile"; }
                ];
                shebangs = [ "make" "gmake" ];
                injection-regex = "(make|makefile|Makefile|mk)";
                comment-token = "#";
                indent = {
                  tab-width = 4;
                  unit = "\t";
                };
              }
              {
                name = "markdown";
                scope = "source.md";
                injection-regex = "md|markdown|qmd";
                file-types = [
                  "md" "markdown" "mkd" "mkdn" "mdwn" "mdown" "markdn"
                  "mdtxt" "mdtext" "qmd" "workbook"
                  { glob = "PULLREQ_EDITMSG"; }
                ];
                roots = [ ".marksman.toml" ];
                language-servers = [ "marksman" "markdown-oxide" ];
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
                block-comment-tokens = {
                  start = "<!--";
                  end = "-->";
                };
                grammar = "markdown";
              }
              {
                name = "meson";
                scope = "source.meson";
                injection-regex = "meson";
                file-types = [
                  { glob = "meson.build"; }
                  { glob = "meson.options"; }
                  { glob = "meson_options.txt"; }
                ];
                comment-token = "#";
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
              }
              {
                name = "nim";
                scope = "source.nim";
                injection-regex = "nim";
                file-types = [ "nim" "nims" "nimble" ];
                shebangs = [];
                comment-token = "#";
                block-comment-tokens = {
                  start = "#[";
                  end = "]#";
                };
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
                language-servers = [ "nimlangserver" ];
              }
              {
                name = "nix";
                scope = "source.nix";
                injection-regex = "nix";
                file-types = [ "nix" ];
                shebangs = [];
                comment-token = "#";
                language-servers = [ "nil" ];
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
              }
              {
                name = "ocaml";
                scope = "source.ocaml";
                injection-regex = "ocaml";
                file-types = [ "ml" ];
                shebangs = [ "ocaml" "ocamlrun" "ocamlscript" ];
                block-comment-tokens = {
                  start = "(*";
                  end = "*)";
                };
                language-servers = [ "ocamllsp" ];
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
              }
              {
                name = "ocaml-interface";
                scope = "source.ocaml.interface";
                file-types = [ "mli" ];
                shebangs = [];
                block-comment-tokens = {
                  start = "(*";
                  end = "*)";
                };
                comment-token = "(**)";
                language-servers = [ "ocamllsp" ];
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
              }
              {
                name = "odin";
                auto-format = true;
                scope = "source.odin";
                file-types = [ "odin" ];
                roots = [ "ols.json" "main.odin" ];
                language-servers = [ "ols" ];
                comment-token = "//";
                block-comment-tokens = {
                  start = "/*";
                  end = "*/";
                };
                indent = {
                  tab-width = 4;
                  unit = "\t";
                };
                formatter = {
                  command = "odinfmt";
                  args = [ "-stdin" "true" ];
                };
              }
              {
                name = "protobuf";
                scope = "source.proto";
                injection-regex = "protobuf";
                file-types = [ "proto" ];
                language-servers = [ "bufls" "pbkit" ];
                comment-token = "//";
                block-comment-tokens = {
                  start = "/*";
                  end = "*/";
                };
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
              }
              {
                name = "python";
                scope = "source.python";
                injection-regex = "py(thon)?";
                file-types = [
                  "cpy" "ipy" "ptl" "py" "py3" "pyi" "pyt" "pyw" "rpy"
                  { glob = ".python_history"; }
                  { glob = ".pythonrc"; }
                  { glob = ".pythonstartup"; }
                  { glob = "SConscript"; }
                  { glob = "SConstruct"; }
                ];
                shebangs = [ "python" ];
                roots = [
                  "poetry.lock"
                  "pyproject.toml"
                  "pyrightconfig.json"
                  "setup.py"
                ];
                comment-token = "#";
                language-servers = [ "pylsp" "ruff" ];
                auto-format = true;
                indent = {
                  tab-width = 4;
                  unit = "    ";
                };
                formatter = {
                  command = "${black}/bin/black";
                  args = ["--line-length" "88" "--quiet" "-"];
                };
              }
              {
                name = "r";
                scope = "source.r";
                injection-regex = "(r|R)";
                file-types = [
                  "r" "R"
                  { glob = ".Rprofile"; }
                  { glob = "Rprofile.site"; }
                  { glob = ".RHistory"; }
                ];
                shebangs = [ "r" "R" ];
                comment-token = "#";
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
                language-servers = [ "r" ];
              }
              {
                name = "racket";
                scope = "source.racket";
                file-types = [ "rkt" "rktd" "rktl" "scrbl" ];
                shebangs = [ "racket" ];
                comment-token = ";";
                indent = { tab-width = 2; unit = "  "; };
                block-comment-tokens = { start = "#|"; end = "|#"; };
                language-servers = [ "racket" ];
                grammar = "scheme";
              }
              {
                name = "rmarkdown";
                scope = "source.rmd";
                language-id = "rmd";
                injection-regex = "(r|R)md";
                file-types = [ "rmd" "Rmd" ];
                indent = { tab-width = 2; unit = "  "; };
                block-comment-tokens = { start = "<!--"; end = "-->"; };
                language-servers = [ "r" ];
              }
              {
                name = "ruby";
                scope = "source.ruby";
                injection-regex = "ruby";
                file-types = [
                  "rb"
                  "rake"
                  "irb"
                  "gemspec"
                  "rabl"
                  "jbuilder"
                  "jb"
                  "podspec"
                  "rjs"
                  "rbi"
                  { glob = "rakefile"; }
                  { glob = "gemfile"; }
                  { glob = "Rakefile"; }
                  { glob = "Gemfile"; }
                  { glob = "Podfile"; }
                  { glob = "Vagrantfile"; }
                  { glob = "Brewfile"; }
                  { glob = "Guardfile"; }
                  { glob = "Capfile"; }
                  { glob = "Cheffile"; }
                  { glob = "Hobofile"; }
                  { glob = "Appraisals"; }
                  { glob = "Rantfile"; }
                  { glob = "Berksfile"; }
                  { glob = "Berksfile.lock"; }
                  { glob = "Thorfile"; }
                  { glob = "Puppetfile"; }
                  { glob = "Fastfile"; }
                  { glob = "Appfile"; }
                  { glob = "Deliverfile"; }
                  { glob = "Matchfile"; }
                  { glob = "Scanfile"; }
                  { glob = "Snapfile"; }
                  { glob = "Gymfile"; }
                ];
                shebangs = [ "ruby" ];
                comment-token = "#";
                language-servers = [ "solargraph" ];
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
              }
              {
                name = "rust";
                scope = "source.rust";
                injection-regex = "rs|rust";
                file-types = [ "rs" ];
                roots = [ "Cargo.toml" "Cargo.lock" ];
                shebangs = [ "rust-script" "cargo" ];
                auto-format = true;
                comment-tokens = [ "//" "///" "//!" ];
                block-comment-tokens = [
                  { start = "/*"; end = "*/"; }
                  { start = "/**"; end = "*/"; }
                  { start = "/*!"; end = "*/"; }
                ];
                language-servers = [ "rust-analyzer" ];
                indent = {
                  tab-width = 4;
                  unit = "    ";
                };
                persistent-diagnostic-sources = [ "rustc" "clippy" ];
                debugger = {
                  name = "lldb-dap";
                  transport = "stdio";
                  command = "${lldb}/bin/lldb-vscode";
                  templates = [
                    {
                      name = "binary";
                      request = "launch";
                      completion = [
                        {
                          name = "binary";
                          completion = "filename";
                        }
                      ];
                      args = {
                        program = "{0}";
                      };
                    }
                    {
                      name = "binary (terminal)";
                      request = "launch";
                      completion = [
                        {
                          name = "binary";
                          completion = "filename";
                        }
                      ];
                      args = {
                        program = "{0}";
                        runInTerminal = true;
                      };
                    }
                    {
                      name = "attach";
                      request = "attach";
                      completion = [ "pid" ];
                      args = { pid = "{0}"; };
                    }
                    {
                      name = "gdbserver attach";
                      request = "attach";
                      completion = [
                        {
                          name = "lldb connect url";
                          default = "connect://localhost:3333";
                        }
                        {
                          name = "file";
                          completion = "filename";
                        }
                        "pid"
                      ];
                      args = {
                        attachCommands = [
                          "platform select remote-gdb-server"
                          "platform connect {0}"
                          "file {1}"
                          "attach {2}"
                        ];
                      };
                    }
                  ];
                };
              }
              {
                name = "scala";
                scope = "source.scala";
                roots = [
                  "build.sbt"
                  "build.sc"
                  "build.gradle"
                  "build.gradle.kts"
                  "pom.xml"
                  ".scala-build"
                ];
                file-types = [ "scala" "sbt" "sc" ];
                comment-token = "//";
                block-comment-tokens = {
                  start = "/*";
                  end = "*/";
                };
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
                language-servers = [ "metals" ];
              }
              {
                name = "scss";
                scope = "source.scss";
                injection-regex = "scss";
                file-types = [ "scss" ];
                block-comment-tokens = {
                  start = "/*";
                  end = "*/";
                };
                language-servers = [ "vscode-css-language-server" ];
                auto-format = true;
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
              }
              {
                name = "solidity";
                scope = "source.sol";
                injection-regex = "(sol|solidity)";
                file-types = ["sol"];
                comment-token = "//";
                block-comment-tokens = {
                  start = "/*";
                  end = "*/";
                };
                indent = {
                  tab-width = 4;
                  unit = "    ";
                };
                language-servers = [ "solc" ];
              }
              {
                name = "sql";
                scope = "source.sql";
                file-types = [ "sql" "dsql" ];
                comment-token = "--";
                block-comment-tokens = {
                  start = "/*";
                  end = "*/";
                };
                indent = {
                  tab-width = 4;
                  unit = "    ";
                };
                language-servers = [ "sqls" ];
                injection-regex = "sql";
              }
              {
                name = "yaml";
                scope = "source.yaml";
                file-types = [ "yml" "yaml" ];
                comment-token = "#";
                indent = {
                  tab-width = 2;
                  unit = "  ";
                };
                language-servers = [
                  "yaml-language-server"
                  "ansible-language-server"
                ];
                injection-regex = "yml|yaml";
              }
              {
                name = "zig";
                scope = "source.zig";
                injection-regex = "zig";
                file-types = [ "zig" "zon" ];
                roots = [ "build.zig" ];
                auto-format = true;
                comment-token = "//";
                language-servers = [ "zls" ];
                indent = {
                  tab-width = 4;
                  unit = "    ";
                };
                formatter = {
                  command = "${zig}/bin/zig";
                  args = [ "fmt" "--stdin" ];
                };
                debugger = {
                  name = "lldb-dap";
                  transport = "stdio";
                  command = "${lldb}/bin/lldb-vscode";
                  templates = [
                    {
                      name = "binary";
                      request = "launch";
                      completion = [
                        {
                          name = "binary";
                          completion = "filename";
                        }
                      ];
                      args = {
                        console = "internalConsole";
                        program = "{0}";
                      };
                    }
                    {
                      name = "attach";
                      request = "attach";
                      completion = [ "pid" ];
                      args = {
                        console = "internalConsole";
                        pid = "{0}";
                      };
                    }
                    {
                      name = "gdbserver attach";
                      request = "attach";
                      completion = [
                        {
                          name = "lldb connect url";
                          default = "connect://localhost:3333";
                        }
                        {
                          name = "file";
                          completion = "filename";
                        }
                        "pid"
                      ];
                      args = {
                        console = "internalConsole";
                        attachCommands = [
                          "platform select remote-gdb-server"
                          "platform connect {0}" "file {1}" "attach {2}"
                        ];
                      };
                    }
                  ];
                };
              }
            ];
            language-server = {
              ansible-language-server = {
                command = "${ansible-language-server}/bin/ansible-language-server";
                args = [ "--stdio" ];
              };
              bash-language-server = with nodePackages; {
                command = "${bash-language-server}/bin/bash-language-server";
                args = [ "start" ];
              };
              bufls = {
                command = "${buf-language-server}/bin/bufls";
                args = [ "serve" ];
              };
              clangd = {
                command = "${clang-tools}/bin/clangd";
              };
              clojure-lsp = {
                command = "${clojure-lsp}/bin/clojure-lsp";
              };
              cmake-language-server = {
                command = "${cmake-language-server}/bin/cmake-language-server";
              };
              crystalline = {
                command = "${crystalline}/bin/crystalline";
                args = [ "--stdio" ];
              };
              cuelsp = {
                command = "${cuelsp}/bin/cuelsp";
              };
              docker-langserver = {
                command = "${dockerfile-language-server-nodejs}/bin/docker-langserver";
                args = [ "--stdio" ];
              };
              docker-compose-langserver = {
                command = "${docker-compose-language-service}/bin/docker-compose-langserver";
                args = [ "--stdio" ];
              };
              dot-language-server = {
                command = "${dot-language-server}/bin/dot-language-server";
                args = [ "--stdio" ];
              };
              elixir-ls = {
                command = "${elixir-ls}/bin/elixir-ls";
                config = {
                  elixirLS.dialyzerEnabled = false;
                };
              };
              elm-language-server = with elmPackages; {
                command = "${elm-language-server}/bin/elm-language-server";
              };
              elvish = {
                command = "${elvish}/bin/elvish";
                args = [ "-lsp" ];
              };
              erlang-ls = {
                command = "${erlang-ls}/bin/erlang_ls";
              };
              gleam = {
                command = "${gleam}/bin/gleam";
                args = [ "lsp" ];
              };
              gopls = {
                command = "${gopls}/bin/gopls";
                config.hints = {
                  assignVariableTypes = true;
                  compositeLiteralFields = true;
                  compositeLiteralTypes = true;
                  constantValues = true;
                  functionTypeParameters = true;
                  parameterNames = true;
                  rangeVariableTypes = true;
                };
              };
              golangci-lint-lsp = {
                command = "${golangci-lint-langserver}/bin/golangci-lint-langserver";
                config = {
                  command = [
                    "${golangci-lint}/bin/golangci-lint"
                    "run" "--out-format"
                    "json" "--issues-exit-code=1"
                  ];
                };
              };
              haskell-language-server = {
                command = "${haskell-language-server}/bin/haskell-language-server-wrapper";
                args = [
                  "--lsp"
                ];
              };
              helm_ls = {
                command = "${helm-ls}/bin/helm_ls";
                args = [ "serve" ];
              };
              jdtls = {
                command = "${jdt-language-server}/bin/jdtls";
              };
              julia = {
                command = "${julia}/bin/julia";
                timeout = 60;
                args = [
                  "--startup-file=no" "--history-file=no"
                  "--quiet" "-e" "using LanguageServer; runserver()"
                ];
              };
              koka = {
                command = "${koka}/bin/koka";
                args = [
                  "--language-server"
                  "--lsstdio"
                ];
              };
              lean = {
                command = "${lean}/bin/lean";
                args = [ "--server" ];
              };
              lua-language-server = {
                command = "${lua-language-server}/bin/lua-language-server";
                config = {
                  Lua = {
                    hint = {
                      enable = true;
                      arrayIndex = "Enable";
                      setType = true;
                      paramName = "All";
                      paramType = true;
                      await = true;
                    };
                  };
                };
              };
              ltex = {
                command = "${ltex-ls}/bin/ltex-ls";
                config = {
                  ltex = {
                    completionEnabled = false;
                    language = "en-US";
                  };
                };
              };
              markdown-oxide = {
                command = "${markdown-oxide}/bin/markdown-oxide";
              };
              marksman = {
                command = "${marksman}/bin/marksman";
                args = [ "server" ];
              };
              metals = {
                command = "${metals}/bin/metals";
                config = {
                  "isHttpEnabled" = true;
                  metals = {
                    inlayHints = {
                      typeParameters = {
                        enable = true;
                      };
                      hintsInPatternMatch = {
                        enable = true;
                      };
                    };
                  };
                };
              };
              mint = {
                command = "${mint}/bin/mint";
                args = [ "ls" ];
              };
              nil = {
                command = "${nil}/bin/nil";
              };
              nimlangserver = {
                command = "${nimlangserver}/bin/nimlangserver";
              };
              pbkit = {
                command = "${pb}/bin/pb";
                args = [ "lsp" ];
              };
              pylsp = with python3Packages; {
                command = "${python-lsp-server}/bin/pylsp";
                config = {
                  pylsp = {
                    plugins = {
                      ruff.enabled = true;
                      black.enabled = true;
                    };
                  };
                };
              };
              ocamllsp = with ocamlPackages; {
                command = "${ocaml-lsp}/bin/ocamllsp";
              };
              ols = {
                command = "${ols}/bin/ols";
                args = [];
              };
              pyright = {
                command = "${pyright}/bin/pyright-langserver";
                args = [ "--stdio" ];
                config = {
                  python = {
                    analysis = {
                      typeCheckingMode = "basic";
                    };
                  };
                };
              };
              pylyzer = {
                command = "${pylyzer}/bin/pylyzer";
                args = [ "--server" ];
              };
              r = {
                command = "${R}/bin/R";
                args = [ "--no-echo" "-e" "languageserver::run()" ];
              };
              racket = {
                command = "${racket}/bin/racket";
                args = [ "-l" "racket-langserver" ];
              };
              ruff = {
                command = "${ruff-lsp}/bin/ruff-lsp";
                config = {
                  settings = {
                    args = [ "--ignore" "E501" ];
                  };
                };
              };
              rust-analyzer = {
                command = "${rust-analyzer}/bin/rust-analyzer";
                config = {
                  inlayHints = {
                    bindingModeHints.enable = false;
                    closingBraceHints.minLines = 10;
                    closureReturnTypeHints.enable = "with_block";
                    discriminantHints.enable = "fieldless";
                    lifetimeElisionHints.enable = "skip_trivial";
                    typeHints.hideClosureInitialization = false;
                  };
                };
              };
              serve-d = {
                command = "${serve-d}/bin/serve-d";
              };
              solargraph = with rubyPackages; {
                command = "${solargraph}/bin/solargraph";
                args = [ "stdio" ];
              };
              solc = {
                command = "${solc}/bin/solc";
                args = [ "--lsp" ];
              };
              sqls = {
                command = "${sqls}/bin/sqls";
              };
              taplo = {
                command = "${taplo}/bin/taplo";
                args = [ "lsp" "stdio" ];
              };
              terraform-ls = {
                command = "${terraform-ls}/bin/terraform-ls";
                args = [ "serve" ];
              };
              texlab = {
                command = "${texlab}/bin/texlab";
              };
              typescript-language-server = with nodePackages; {
                command = "${typescript-language-server}/bin/typescript-language-server";
                args = [ "--stdio" ];
                config = {
                  hostInfo = "helix";
                  typescript.inlayHints = {
                    includeInlayEnumMemberValueHints = true;
                    includeInlayFunctionLikeReturnTypeHints = true;
                    includeInlayFunctionParameterTypeHints = true;
                    includeInlayParameterNameHints = "all";
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                    includeInlayPropertyDeclarationTypeHints = true;
                    includeInlayVariableTypeHints = true;
                  };
                  javascript.inlayHints = {
                    includeInlayEnumMemberValueHints = true;
                    includeInlayFunctionLikeReturnTypeHints = true;
                    includeInlayFunctionParameterTypeHints = true;
                    includeInlayParameterNameHints = "all";
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                    includeInlayPropertyDeclarationTypeHints = true;
                    includeInlayVariableTypeHints = true;
                  };
                };
              };
              vscode-css-language-server = with nodePackages; {
                command = "${vscode-langservers-extracted}/bin/vscode-css-language-server";
                args = [ "--stdio" ];
                config = {
                  provideFormatter = true;
                  css = {
                    validate = {
                      enable = true;
                    };
                  };
                };
              };
              vscode-html-language-server = with nodePackages; {
                command = "${vscode-langservers-extracted}/bin/vscode-html-language-server";
                args = [ "--stdio" ];
                config = {
                  provideFormatter = true;
                };
              };
              vscode-json-language-server = with nodePackages; {
                command = "${vscode-langservers-extracted}/bin/vscode-json-language-server";
                args = [ "--stdio" ];
                config = {
                  provideFormatter = true;
                  json = {
                    validate = {
                      enable = true;
                    };
                  };
                };
              };
              yaml-language-server = {
                command = "${yaml-language-server}/bin/yaml-language-server";
                args = [ "--stdio" ];
              };
              zls = {
                command = "${zls}/bin/zls";
              };
            };
          };
        };
      };
    };
  };
}
