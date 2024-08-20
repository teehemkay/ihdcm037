{
  description = "frontend standard development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default-darwin";
    flake-utils.url = "github:numtide/flake-utils";

    # Override flake-utils systems to mine
    flake-utils.inputs.systems.follows = "systems";
  };

  outputs = { nixpkgs, systems, flake-utils, ... }:
    let
      eachSystem = f:
        flake-utils.lib.eachSystem (import systems)
        (system: f nixpkgs.legacyPackages.${system});

    in eachSystem (pkgs:
      let
        inherit (pkgs) stdenv lib mkShell;
        inherit (pkgs.darwin.apple_sdk.frameworks) CoreFoundation CoreServices;

      in {
        devShells = {
          default = mkShell {
            packages = [ pkgs.hy pkgs.python3 ]
              ++ lib.optionals stdenv.isDarwin [ CoreFoundation CoreServices ];
          };
        };
      });
}
