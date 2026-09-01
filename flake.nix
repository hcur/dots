{
  description = "$home";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    nur.url = "github:nix-community/NUR";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-cachyos-kernel,
    nur,
    ...
  }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          nur.overlays.default
          nix-cachyos-kernel.overlays.default  
        ];
      };
      secrets = builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");
    in {

      homeConfigurations."hc" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };

        modules = [ ./home.nix ];
      };

      nixosConfigurations = {
	      "songbird" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };

          modules = [
            { nixpkgs.pkgs = pkgs; }
            ./nix/hw/songbird.nix
            ./nix/hosts/songbird.nix
          ];
	      };

        "nest" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit secrets;
          };

          modules = [
            { nixpkgs.pkgs = pkgs; }
            ./nix/hw/nest.nix
            ./nix/hosts/nest.nix

            ./nix/modules/beszel.nix
            ./nix/modules/sure/docker-compose.nix
          ];
        };
      };
    };
}
