  { config, ... }:

  config = {

    nix.settings.experimental-features = [ "nix-command" "flakes"  ];
    options.modules.wm.dwm.enable = true;

  }
