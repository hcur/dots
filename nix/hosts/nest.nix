{ config, pkgs, ... }:

{
  boot = {
    loader.systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "nest";
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  time.timeZone = "America/New_York";

  i18n = {
    default = "en_US.UTF-8";
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

  virtualisation.docker = {
    enable = true;
  }

  environment.systemPackages = with pkgs; [
    vim
    vscode
    git
    compose2nix
  ];
  
  system.stateVersion = "25.11";
}
