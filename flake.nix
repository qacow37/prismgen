{
    description = "Flake providing dev shells for development on prismgen for prismnix";

    inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		flake-utils.url = "github:numtide/flake-utils";
    };
    outputs = {flake-utils, nixpkgs, ...}:
        flake-utils.lib.eachDefaultSystem (system:
            let
                pkgs = nixpkgs.legacyPackages.${system};
            in
            {
                devShells = {
                    default = pkgs.mkShell {
                        #
                        # Build CLI with
                        # pyhthon dependencies
                        #
                        packages = with pkgs; [
                            python3
                            python3Packages.requests
                            python3Packages.packaging
                            python3Packages.requests-ratelimiter
                            python3Packages.typer
                            python3Packages.jinja2

                            pyright
                        ];
                    };
                    git-lfs = pkgs.mkShellNoCC {
                        packages = with pkgs; [
                            git-lfs
                        ];
                    };
                };
            }
        );
}
