{ config, pkgs, inputs, ... }:

/* songbird.nix -- config for gaming desktop */

{
  system.stateVersion = "26.05";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
  };
  
  networking = {
    networkmanager.enable = true;
  };

  users.users.hc = {
    isNormalUser = true;
    description = "Hayden Curfman";
    extraGroups = [ "video" "docker" "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  time.timeZone = "America/New_York";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  services = {
    desktopManager.plasma6.enable = true;

    displayManager.ly = {
      enable = true;
      settings = {
        animation = "colormix";
      };
    };

    emacs = {
      enable = true;
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
  };

  security.rtkit.enable = true;

  programs = {
    firefox = {
      enable = true;
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      localNetworkGameTransfers.openFirewall = true;
    };
    zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "half-life";
      };
    };
  };

  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # tui
    ripgrep
    neovim
    stow
    git
    gh
    lsd
    unzip
    comma

    # gui
    discord
    ghostty
    furmark
    spotify
    nyxt
    qutebrowser
    linux-wallpaperengine
    gnome-disk-utility
    via
    protonup-qt
    limo

    # development
    go
    gcc
    ollama-rocm

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
