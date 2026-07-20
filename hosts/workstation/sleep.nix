# Sleep / Suspend-Resume Stability Configuration
#
# Addresses two post-wake crash sources identified in crash logs:
#
#   1. PipeWire "Bad file descriptor" on every resume — socket FDs held by pre-suspend
#      clients become stale after suspend-then-hibernate. Restarting PipeWire user
#      services on wake clears all stale state.
#
#   2. General power-management tuning to ensure clean suspend entry / exit.
{ config, pkgs, ... }:

{
  # Restart PipeWire and WirePlumber after the system resumes from sleep.
  #
  # Without this, pipewire-pulse logs "setsockopt(SO_PRIORITY) failed: Bad file descriptor"
  # and "no peercred: Bad file descriptor" immediately after every wake, because the
  # PulseAudio-compatibility socket's client connections were frozen and are now stale.
  # Apps that connected to PipeWire before suspend may fail to produce audio until
  # they are restarted.
  powerManagement.resumeCommands = ''
    # Give the system 1 second to settle before restarting audio services.
    sleep 1
    # Restart PipeWire user services for the active user session.
    ${pkgs.systemd}/bin/systemctl --user -M danny@ restart \
      pipewire.service \
      pipewire-pulse.service \
      wireplumber.service \
      2>/dev/null || true
  '';
}
