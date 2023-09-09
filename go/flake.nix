{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
        default = pkgs.buildGoModule {
          name = "web-server-go";

          src = gitignore.lib.gitignoreSource ./.;

          vendorSha256 = "sha256-Khr8IFhDpOvn6Vp3RtWsPWAymLVM9Yxb7Q5xwcxR8NU=";
        };
      };
    });
}
