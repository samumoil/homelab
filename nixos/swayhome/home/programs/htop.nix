{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        htop = {
          enable = false;
          settings = {
            hide_kernel_threads = true;
            hide_threads = true;
            hide_userland_threads = true;
            show_cpu_frequency = true;
            show_cpu_temperature = true;
            show_cpu_usage = true;
            show_program_path = false;
            tree_view = true;
            vim_mode = true;
          };
        };
      };
    };
  };
}
