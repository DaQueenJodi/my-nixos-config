  { pkgs,
    ...
  }: {

  imports = [
    ./hardware
    ./wm
  ];
}
