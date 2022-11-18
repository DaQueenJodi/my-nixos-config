# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # LICENSES
  nixpkgs.config.allowUnfree = true;
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    xkbOptions = "ctrl:nocaps";
  };
  security.sudo = {
    enable = true;
    extraConfig = ''
    Defaults pwfeedback
    '';
  };

  services.xserver.displayManager.lightdm = {
#    enable = true;
  };  

  modules.wm.awesome.enable = true;
  # HARDWARE

  # AUDIO
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.support32Bit = config.hardware.pulseaudio.enable;


 /* virtualisation.virtualbox = {
    host = {
      enable = true;
      enableExtensionPack = true;
    };
    guest = {
      enable = true;
      x11 = true;
    };
  };
  users.extraGroups.vboxusers.members = [ "jodi" ];
  */
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jodi = {
    isNormalUser = true;
    extraGroups = ["wheel" "mlocate"]; 
    packages = with pkgs; [
      qbittorrent
      godot
      
      firefox-wayland
      flatpak
      nix-index
      pulsemixer
      bat
      ranger
      mlocate
      wget
      curl
      unzip
      zip
      mpv

      (pkgs.callPackage ../../packages/queercat.nix {} )

      clang

      #gamescope # micro-compositor to help with games running in wine/proton
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty # terminal
    openvpn # vpn stuffs
    killall # killing windows
    git

    # https://github.com/nix-community/nix-direnv
    direnv
    nix-direnv
   ];
    nix.extraOptions = ''
     keep-outputs = true
     keep-derivations = true
   '';
    environment.pathsToLink = [
     "/share/nix-direnv"
    ];
  # NETWORKING
  boot.extraModulePackages = with config.boot.kernelPackages; [
    (rtl88x2bu.overrideAttrs (old: {
      src = pkgs.fetchFromGitHub {
        owner = "RinCat";
        repo = "RTL88x2BU-Linux-Driver";
        rev = "624f131210b3f174342a79e971d980de79ce8ffd";
        hash = "sha256-/IHVObNDa5+ihOOctsO3/X+/4csjWwmStckTJOqLg2E=";
      };
    }))
  ];

  boot.kernelModules = ["r88x2bu"];
  boot.kernelParams = ["mitigations=off"];
  networking.nameservers = ["1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4"];
  networking.wireless.iwd.enable = true;
  networking.hostName = "";

  #MISC
  programs.fish.enable = true;

  # FONTS
  fonts.fonts = with pkgs; [
    noto-fonts
    awesome
    liberation_ttf
    fira-code
    fira-code-symbols
    cantarell-fonts
    nerdfonts
  ];

  # FLATPAK
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  services.flatpak.enable = true;

 # Make winit apps like alacritty or foot have the same scaling on both monitors
 environment.variables.WINIT_X11_SCALE_FACTOR = "1";

 # mlocate for file indexing
 services.locate = {
    enable = true;
    locate = pkgs.mlocate;
    interval = "hourly";
    localuser = null;
  };

 # MODULE ENABLING
 modules.editor.neovim.enable = true;
 modules.editor.lsp.enable = true;
 # modules.editor.emacs.enable = true;
 #modules.gaming.steam.enable = true; use flatpak instead
 modules.misc.scripts.enable = true;
 

 # SERVICES
 services.emacs.enable = true;
 services.openssh.enable = true;
 services.jellyfin = {
  enable = true;
  openFirewall = true;
 };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
