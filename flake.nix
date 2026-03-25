{
    description = "$home";

    inputs = {
        nixpkgs = {
            url = "github:NixOS/nixpkgs/nixos-unstable";
        };

        nix-gaming.url = "github:hcur/nix-gaming";
    };

    outputs = {
        self,
        nixpkgs,
        ...
    }@inputs: {
        nixosConfigurations = {
            songbird = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = {inherit inputs;};
                modules = [
                    ./nix/songbird.nix
                    ./nix/songbird_hw.nix
                ];
            };
        };
    };
}
