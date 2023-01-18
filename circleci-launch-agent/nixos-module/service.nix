{ circleci-launch-agent }:
{ lib
, pkgs
, config
, runnerName
, cfg ? config.services.circleci-runners
, ...
}:
with lib;

let
  agentConfig = {
    api = {
      auth_token = cfg.auth_token;
    };
    runner = {
      name = runnerName;
      disable_auto_update = true;
    };
  };
  configFile = (pkgs.formats.yaml { }).generate "circleci-runner-${runnerName}-config.yaml" agentConfig;
in
# Inspired by https://circleci.com/docs/runner-installation-linux/#enable-the-systemd-unit
{
  description = "CircleCI Runner ${runnerName}";
  after = [ "network.target" ];
  wantedBy = [ "multi-user.target" ];
  serviceConfig = {
    Restart = "always";
    # TODO maybe configure a user?
    # User = "circleci";
    NotifyAccess = "exec";
    TimeoutStopSec = "18300";
  };
  script = ''
    ${circleci-launch-agent}/bin/circleci-launch-agent --config ${configFile}
  '';
}
