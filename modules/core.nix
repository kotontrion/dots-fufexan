{
  pkgs,
  lib,
  ...
}:
# configuration shared by all hosts
{
  documentation.dev.enable = true;

  # enable zsh autocompletion for system packages (systemd, etc)
  environment.pathsToLink = ["/share/zsh"];

  i18n = {
    defaultLocale = "en_US.UTF-8";
    # saves space
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
      "ro_RO.UTF-8/UTF-8"
    ];
  };

  # graphics drivers / HW accel
  hardware.opengl.enable = true;

  # enable programs
  programs = {
    less.enable = true;

    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting = {
        enable = true;
        patterns = {"rm -rf *" = "fg=black,bg=red";};
        styles = {"alias" = "fg=magenta";};
        highlighters = ["main" "brackets" "pattern"];
      };
    };
  };

  # don't ask for password for wheel group
  security.sudo.wheelNeedsPassword = false;

  # don't touch this
  system.stateVersion = lib.mkDefault "23.11";

  time.timeZone = lib.mkDefault "Europe/Bucharest";

  users.users.mihai = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["adbusers" "input" "libvirtd" "networkmanager" "plugdev" "transmission" "video" "wheel"];
  };

  # compresses half the ram for use as swap
  zramSwap.enable = true;
}
