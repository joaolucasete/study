{
  description = "Machine learning environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, utils, nixpkgs }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShell = with pkgs; mkShell {
          name = "ml-env";
          buildInputs = [
            python39
            python310Packages.pandas
            python310Packages.scikit-learn
            python310Packages.jedi-language-server
          ];
        };
      });
}

