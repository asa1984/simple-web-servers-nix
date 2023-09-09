{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    gitignore.url = "github:hercules-ci/gitignore.nix";
    gitignore.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    gitignore,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      packages = {
        default = pkgs.stdenvNoCC.mkDerivation {
          name = "web-server-zig";

          src = gitignore.lib.gitignoreSource ./.;

          nativeBuildInputs = [pkgs.zig];

          buildPhase = ''
            mkdir -p $out
            mkdir -p .cache/{p, z, tmp}
            ln -s ${pkgs.callPackage ./deps.nix {}} .cache/p
            zig build install --cache-dir $(pwd)/zig-cache --global-cache-dir $(pwd)/.cache --prefix $out
          '';
        };
      };
    });
}
