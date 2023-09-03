{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      packages = {
        default = pkgs.rustPlatform.buildRustPackage {
          name = "web-server-rust";

          src = ./.;

          cargoLock = {lockFile = ./Cargo.lock;};
        };
      };
    });
}
