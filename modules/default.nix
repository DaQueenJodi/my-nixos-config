{pkgs, ...}: {
  imports = [
    ./hardware
    ./wm
    ./editor
  ];
}
