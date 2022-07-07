{
  inputs,
  lib,
  pkgs,
  ...
} @ args: {
  programs.helix = {
    enable = true;
    package = inputs.helix.packages.${pkgs.system}.default;

    languages = import ./languages.nix args;

    settings = {
      theme = "catppuccin_mocha";
      editor = {
        true-color = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
      };

      keys.normal.space.u = {
        f = ":format"; # format using LSP formatter
        a = ["select_all" ":pipe alejandra"]; # format Nix with Alejandra
        w = ":set whitespace.render all";
        W = ":set whitespace.render none";
      };
    };

    themes = let
      variants = ["catppuccin_latte" "catppuccin_frappe" "catppuccin_macchiato" "catppuccin_mocha"];
    in
      lib.genAttrs variants (n: builtins.fromTOML (builtins.readFile "${inputs.catppuccin-helix}/italics/${n}.toml"));
  };
}
