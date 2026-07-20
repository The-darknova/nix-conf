# AMD Workstation — Hardware-Specific Configuration
#
# This file contains settings that are specific to AMD-based hardware.
# It is intentionally separated from configuration.nix so the rest of the
# config remains portable across different machines.
#
# Apply this file only on AMD workstations.
{ config, lib, ... }:

{
  # Explicitly load the AMDGPU kernel module early in the boot process.
  # This prevents driver races during resume from suspend that can cause
  # a black screen or GPU hang on wake.
  boot.kernelModules = [ "amdgpu" ];

  # AMD-specific kernel parameters:
  #   mem_sleep_default=deep — Use S3 (deep) sleep instead of s2idle.
  #     Deep sleep properly powers down the GPU, preventing hangs and
  #     kernel panics on resume. Applies to any AMD system.
  #   amdgpu.sg_display=0 — Disables scatter-gather display DMA.
  #     Fixes a known AMDGPU bug causing black screen / kernel panic on
  #     wake from suspend on affected GPU generations (RX 5000+).
  boot.kernelParams = [
    "mem_sleep_default=deep"
    "amdgpu.sg_display=0"
  ];

  # Enable AMD CPU microcode updates if redistributable firmware is enabled.
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
