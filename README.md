# Nix packaging of the CircleCI Launch Agent

Status: Nothing to see here yet. Come back later.

## How to try it out

The flake exposes a `nixosModule`: `nixosModules.x86_64-linux.default`.
You can use it in your `configuration.nix` in the same way that `circleci-launch-agent/nixos-module-test.nix` uses it:

``` nix
{
  imports = [
    circleCiAgentNixOSModule
  ];
  services.circleci-runners.foobar = {
    enable = true;
    auth_token = "foobar";
  };
}
```
