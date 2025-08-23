{ config, pkgs, ... }:
let
    unstableTarball = fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
    unstable = import unstableTarball { config = config.nixpkgs.config; };
in
{
  imports =
    [
      ./hardware.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_xanmod_stable;
  };
  
  networking = {
    hostName = "nixos";
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

    displayManager.sddm = {
      enable = true;
    };

    emacs = {
      enable = true;
      package = unstable.emacs;
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

  virtualisation.docker = {
    enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    firefox = {
	enable = true;
	package = unstable.firefox;
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
    unstable.neovim
    stow
    git
    gh
    lsd
    pfetch-rs

    # gui
    discord
    ghostty
    furmark
    spotify
    pyfa
    gnome-disk-utility
    via
    albert
    insomnia
    protonup-qt

    unstable.vscode
    code-cursor

    # development
    go
    gopls
    gcc
    typescript-language-server

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

  system.stateVersion = "25.05";
}
