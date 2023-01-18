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
    type = types.attrsOf (types.submodule { options = import ./nixos-module/options.nix; });
  };
  config = {
    systemd.services = flip mapAttrs' cfg (n: v:
      nameValuePair "circleci-runner-${n}"
        (import ./nixos-module/service.nix
          { inherit circleci-launch-agent; }
          (args // { cfg = cfg.${n}; }))
    );
  };
}
