{
  description = "Circleci launch agent";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      circleci-launch-agent = pkgs.callPackage ./circleci-launch-agent { };
      nixosModule = import ./circleci-launch-agent/nixos-module.nix { inherit circleci-launch-agent; };
    in
    {
      packages.${system}.default = circleci-launch-agent;
      nixosModules.${system}.default = nixosModule;
      checks.${system} = {
        nixos-module-test = import ./circleci-launch-agent/nixos-module-test.nix {
          inherit (pkgs) nixosTest;
          inherit nixosModule;
        };
      };
    };
}
