{ inputs, config, lib, pkgs, ... }:

{
  home.username = "hc";
  home.homeDirectory = "/home/hc";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    ripgrep
    stow
    gh
    lsd
    unzip
    microfetch
    vim

    discord
    ghostty
    spotify
    via
    protonup-qt
    limo
    vlc
    vscode
    calibre
    transmission_4
    emacs

    go
    gopls
    nodejs
    gcc
    nixfmt

    nur.repos.lonerOrz.helium

    inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "Hayden Curfman";
      user.email = "hlc1@williams.edu";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "half-life";
    };
    history.size = 10000;
  };
}
