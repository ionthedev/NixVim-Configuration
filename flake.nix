{
  description = "A nixvim configuration with devShells";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    { nixpkgs, nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = { pkgs, system, ... }: let
        nixvimLib = nixvim.lib.${system};
        nixvim' = nixvim.legacyPackages.${system};
        nixvimModule = {
          inherit pkgs;
          module = import ./config; # import your module directly
          extraSpecialArgs = {};
        };

        nvim = nixvim'.makeNixvimWithModule nixvimModule;
      in {
        checks = {
          default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
        };

        packages = {
          default = nvim;
        };

        devShells = {
          default = pkgs.mkShell {
            buildInputs = [
              pkgs.cmake
              pkgs.gcc
              pkgs.python310Full
              pkgs.neovim  # You can replace this with `nvim` from nixvim if needed
            ];

            shellHook = ''
              echo "DevShell ready with Neovim and other tools!"
            '';
          };
        };
      };
    };
}

