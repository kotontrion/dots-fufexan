inputs: _: prev: {
  # instant repl with automatic flake loading
  repl = prev.callPackage ./repl {};

  discord-canary = prev.callPackage ./discord.nix {
    pkgs = prev;
    inherit inputs;
    inherit (prev) lib;
  };

  gdb-frontend = prev.callPackage ./gdb-frontend {};

  TL = prev.callPackage ./TL {};

  regreet = prev.callPackage ./regreet {};

  waveform = prev.callPackage ./waveform {};

  spotify = prev.callPackage ./spotify {};

  sway-hidpi = import ./sway-hidpi.nix prev;
}
