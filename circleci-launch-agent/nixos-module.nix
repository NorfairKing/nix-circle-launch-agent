{ circleci-launch-agent }:
{ lib
, pkgs
, config
, ...
}@args:
with lib;

let cfg = config.services.circleci-runners;
in
{
  options.services.circleci-runners = mkOption {
    default = { };
    type = types.attrsOf (types.submodule {
      options = import ./nixos-module/options.nix args;
    });
  };
  config = {
    systemd.services = flip mapAttrs' cfg (name: v:
      nameValuePair "circleci-runner-${name}"
        (import ./nixos-module/service.nix
          { inherit circleci-launch-agent; }
          (args // {
            runnerName = name;
            cfg = config.services.circleci-runners.${name};
          }))
    );
  };
}
