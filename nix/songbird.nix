{ config, pkgs, inputs, ... }:

/* songbird.nix -- config for gaming desktop */

{
  system.stateVersion = "26.05";

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.overlays = [
    inputs.nur.overlays.default
    inputs.nix-cachyos-kernel.overlays.default
  ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;
    # trying to fix issues with rx 7800xt---claude suggested this for power
    # management, not sure if it's helping or needed
    kernelParams = [ "pcie_aspm=off" ];

    supportedFilesystems = [ "ntfs" ];
  };

  networking = {
    networkmanager.enable = true;
  };

  users.users.hc = {
    isNormalUser = true;
    description = "Hayden Curfman";
    extraGroups = [ "video" "networkmanager" "wheel" "input" ];
    shell = pkgs.zsh;
  };

  time.timeZone = "America/New_York";

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    enableRedistributableFirmware = true;
    enableAllFirmware = true;
  };

  services = {
    desktopManager.plasma6.enable = true;

    displayManager.ly = {
      enable = true;
      settings = {
        animation = "colormix";
      };
    };

    # audio
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    printing.enable = true;

    # for iOS automatic mount
    usbmuxd.enable = true;

    # for keychron k6 & via
    udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", \
        MODE="0660", GROUP="input", TAG+="uaccess", TAG+="udev-acl"
    '';
  };

  security.rtkit.enable = true;

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    zsh.enable = true;
  };

  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    gh

    # fonts
    nerd-fonts.fira-code

    # misc
    libimobiledevice
    ifuse
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    elisa
    gwenview
    okular
    kate
    khelpcenter
    ark
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH =
      "/home/hc/.local/share/Steam/compatibilitytools.d";
  };
}
