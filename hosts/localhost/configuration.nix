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
  services.xserver.enable = true;
  modules.wm.dwm.enable = true;
  

  # HARDWARE

  # AUDIO
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.support32Bit = config.hardware.pulseaudio.enable;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jodi = {
    isNormalUser = true;
    extraGroups = ["wheel" "mlocate"]; 
    packages = with pkgs; [
      firefox
      flatpak
      nix-index
      pulsemixer
      bat
      ranger
      mlocate
      wget
      curl
      #gamescope # micro-compositor to help with games running in wine/proton
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty # terminal
    tdrop # terminal dropdown
    xclip # clipboard
    rofi # launcher
    picom # compositor
    openvpn # vpn stuffs
    pamixer # changing volume
    killall # killing windows
    git 
    cava # for bar
    dash # for launchers
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
 modules.gaming.steam.enable = true;


 # SERVICES
 services.openssh = {
    enable = true;
    gatewayPorts = "yes";
  };
 services.jellyfin.enable = true;
 services.jellyfin.openFirewall = true;

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
