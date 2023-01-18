{ circleci-launch-agent }:
{ lib
, pkgs
, config
, cfg ? config.services.circleci-runners
, ...
}:
with lib;
{
  description = "CircleCI Runner";
}
