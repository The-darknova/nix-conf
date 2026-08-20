# Hardware-Specific Configuration
#
# Contains minimal hardware-specific settings (like microcode) that are safe
# to keep or will gracefully do nothing on non-matching hardware, ensuring
# this configuration remains portable across different machines.
{ config, lib, pkgs, ... }:

{
  # AMD CPU microcode updates (requires hardware.enableRedistributableFirmware = true).
  # On non-AMD systems, this is a harmless no-op.
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Enable graphics and install AMD ROCm OpenCL drivers (Required for DaVinci Resolve)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };
}
