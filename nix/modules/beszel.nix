{ config, pkgs, secrets, ... }:

# Module to configure a beszel monitoring agent.
# Points to nest as the hub. Requires each machine to
#  have a token file at /var/lib/beszel-agent/token

{
  services.beszel.agent = {
    enable = true;
    openFirewall = true;

    environment = {
      # URL is localhost right now; will need to change this if/when
      # I ever get more machines in my homelab
      HUB_URL = "127.0.0.1:8090";

      KEY = secrets.beszel.hub-key;
      TOKEN_FILE = "/var/lib/beszel-agent/token";
    };
  };
}