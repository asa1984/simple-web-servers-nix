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

      code = pkgs.buildNpmPackage {
        name = "web-server-nodejs";

        buildInputs = with pkgs; [
          nodejs-18_x
        ];

        src = ./.;

        npmDepsHash = "sha256-oNUCfoESMRAlSl+TAS9maIi/NbkD4Th95yH8rchpFYA=";

        npmBuild = "npm run build";

        installPhase = ''
          mkdir $out
          cp dist/out.js $out
        '';
      };
    in {
      packages = {
        default = pkgs.writeScriptBin "web-server-nodejs" ''
          ${pkgs.nodejs-18_x}/bin/node ${code}/out.js
        '';
      };
    });
}
