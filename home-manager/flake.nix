{
	description = "Home Manager configuration of saturnfulcrum";
		
	inputs = {
	# Specify the source of Home Manager and Nixpkgs.
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
		home-manager = {
			url = "github:nix-community/home-manager/release-24.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nix-colors.url = "github:misterio77/nix-colors";
	};

	outputs = { nixpkgs, home-manager, ... }@inputs:
	let
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {
	#Below code should be put into home manager for root user.
	#nixosConfigurations.shakarisviewerofcarnage = lib.nixosSystem {
	#  inherit system;
	#  modules = [ ./configuration.nix ];
	#}
		homeConfigurations."saturnfulcrum" = home-manager.lib.homeManagerConfiguration {
			inherit pkgs;
			
			# Specify your home configuration modules here, for example,
			# the path to your home.nix.
			extraSpecialArgs = { inherit inputs; };
			modules = [ ./home.nix ];
			
			# Optionally use extraSpecialArgs
			# to pass through arguments to home.nix
		};
	};
}
