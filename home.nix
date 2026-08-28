{ inputs, config, lib, pkgs, ... }:

{

  home = {
    username = "hc";
    homeDirectory = "/home/hc";
    stateVersion = "26.11";

    packages = with pkgs; [
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

      # custom packages
      (callPackage ./nix/netlogo.nix {})

      # nur packges
      nur.repos.lonerOrz.helium

      # install home-manager under home-manager
      #inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    file = {
      ".emacs.d/init.el".source = config.lib.file.mkOutOfStoreSymlink "/home/hc/.dotfiles/emacs/.emacs.d/init.el";
    };

  };

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

    shellAliases = {
      dots = "cd ~/.dotfiles";
    };
    
    history.size = 10000;
  };
}
