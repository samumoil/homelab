{ ... }: {
  services = {
    libinput = {
      enable = false;
      mouse = {
        disableWhileTyping = true;
        naturalScrolling = true;
      };
      touchpad = {
        disableWhileTyping = true;
        naturalScrolling = true;
      };
    };
  };
}
