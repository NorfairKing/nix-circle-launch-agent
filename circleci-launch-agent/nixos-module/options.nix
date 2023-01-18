{ circleci-launch-agent }:
{ lib, pkgs, config, ... }:

with lib;

let
  cfg = config.services.circleci-runners;
in
{
  enable = mkEnableOption "Circleci runner";
}
