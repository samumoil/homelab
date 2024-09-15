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
          bc # gnu software calculator
          catdoc # microsoft office to text converter
          ghostscript # convert pdf document
          odt2txt # convert odt to txt
          poppler_utils # pdf rendering library
          xlsx2csv # convert xlsx to csv
        ];
      };
    };
  };
}
