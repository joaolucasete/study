{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
  };

  outputs = { self, nixpkgs, devenv, ... } @ inputs:
    let
      systems = [ "x86_64-linux" "i686-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = f: builtins.listToAttrs (map (name: { inherit name; value = f name; }) systems);
    in
    {
      devShells = forAllSystems
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                {
                  services.postgres = {
                    enable = true;
                    initialScript = ''
                      CREATE USER postgres WITH SUPERUSER PASSWORD 'postgres';
                    '';
                  };
                  # https://devenv.sh/reference/options/
                  packages = with pkgs; [
                    elixir
                    elixir_ls
                    inotify-tools
                    nodejs

                    rnix-lsp
                  ];
                  enterShell = ''
                  '';
                }
              ];
            };
          });
    };
}


