{ config, pkgs, secrets, ... }:

{
  environment.systemPackages = with pkgs; [
    calibre
  ];

  services.calibre-web = {
    enable = true;
    listen = {
      ip = "0.0.0.0";
      port = 8083;
    };
    openFirewall = true;
    options = {
      enableBookUploading = true;
    };
  };
}