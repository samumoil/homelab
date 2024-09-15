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
      home = {
        packages = [
          (
            ruby.withPackages ( ps:
              with ps; [
                nokogiri
                pry
              ]
            )
          )
        ];
      };
    };
  };
}
