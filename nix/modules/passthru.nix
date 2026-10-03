{ config, pkgs, secrets, ... }:

{
	networking = {
		networkmanager.ensureProfiles.profiles = {
			"eno1-share" = {
				connection = {
					id = "eno1-share";
					type = "ethernet";
					interface-name = "eno1";
				};

				ipv4 = {
					method = "shared";
				};
			};
		};

		networkmanager.wifi.powersave = false;

		firewall.trustedInterfaces = [ "eno1" ];
	};
}
