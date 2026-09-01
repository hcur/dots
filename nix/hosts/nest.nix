{ config, pkgs, ... }:

{
  system.stateVersion = "26.11";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "nest";
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

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

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.lxqt.enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  users.users.hc = {
    isNormalUser = true;
    description = "Hayden Curfman";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    # essentials
    vim
    vscode
    git
    gh

    # homelabbity
    git-crypt
    openssl
    compose2nix
  ];

  # homelab ===

  networking.firewall.allowedTCPPorts = [ 8090 ];

  virtualisation.containers.registries.settings = {
    unqualified-search-registries = [ "docker.io" ];
  };

  services.beszel.hub = {
    enable = true;
    host = "0.0.0.0";
    port = 8090;
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
    };
  };
}
