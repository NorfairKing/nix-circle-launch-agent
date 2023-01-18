{ lib, pkgs, config, ... }:

with lib;

{
  enable = mkEnableOption "Circleci runner";
  auth_token = mkOption {
    type = types.str;
    description = "The auth token to set as api.auth_token";
  };
}
