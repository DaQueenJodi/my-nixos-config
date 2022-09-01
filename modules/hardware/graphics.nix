{
  lib,
  pkgs,
  config,
  ...
}: {
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      mesa.drivers
      rocm-opencl-icd
      rocm-opencl-runtime
      clinfo
    ];
  };
}
