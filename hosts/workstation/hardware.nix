# AMD Workstation — Hardware-Specific Configuration
#
# This file contains settings specific to AMD-based hardware (Ryzen APU / dGPU).
# Separated from configuration.nix so the rest of the config is portable.
#
# Apply this file only on AMD workstations.
{ config, lib, ... }:

{
  # AMD CPU microcode updates (requires hardware.enableRedistributableFirmware = true).
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Explicitly load the AMDGPU kernel module.
  # For AMD APUs (integrated GPU), keeping this in kernelModules (not initrd) avoids
  # a race with the LUKS unlock framebuffer while still ensuring early user-space load.
  boot.kernelModules = [ "amdgpu" ];

  # AMD / NVMe kernel parameters:
  #
  #   mem_sleep_default=deep
  #     Use S3 (deep) sleep instead of s2idle. Deep sleep properly powers down the
  #     GPU and prevents hangs on resume. Required on all AMD platforms.
  #
  #   amdgpu.sg_display=0
  #     Disables scatter-gather display DMA. Fixes a known AMDGPU bug causing black
  #     screen / kernel panic on wake from suspend (RX Vega / Barcelo / Navi+).
  #
  #   amdgpu.gpu_recovery=1
  #     Enables automatic GPU ring-buffer reset on timeout (TDR). Without this, a GPU
  #     command ring hang causes the compositor (Hyprland/KWin) to exit with
  #     "irqs disabled", killing all Wayland clients and crashing the session.
  #     With it, the kernel resets the ring and the compositor survives.
  #
  #   nvme.noacpi=1
  #     Prevents ACPI from overriding the NVMe controller's own power state management
  #     during suspend/resume. The Samsung MZVLQ series (and others) apply a
  #     "platform quirk: setting simple suspend" every boot; this parameter stops
  #     ACPI from interfering with that path, avoiding potential data corruption and
  #     wake failures on the NVMe.
  boot.kernelParams = [
    "mem_sleep_default=deep"
    "amdgpu.sg_display=0"
    "amdgpu.gpu_recovery=1"
    "nvme.noacpi=1"
  ];
}
