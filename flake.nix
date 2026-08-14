{
  description = "$home";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };

  outputs = inputs@{
    nixpkgs,
    home-manager,
    nur,
    nix-cachyos-kernel,
    ...
  }: {
    nixosConfigurations = {
      songbird = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
          specialArgs = {inherit inputs;};
            modules = [
              ./nix/songbird.nix
              ./nix/songbird_hw.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.users.hc = import ./home.nix;

                home-manager.extraSpecialArgs = {inherit inputs;};
              }
            ];
      };
    };

    homeConfigurations.hc =
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        extraSpecialArgs = {
          inherit inputs;
        };

        modules = [
          ./home.nix
        ];
      };
  };
}
