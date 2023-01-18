{ nixosTest
, nixosModule
}:
nixosTest ({ lib, pkgs, ... }: {
  name = "circleci-runner-module-test";
  nodes.machine = {
    imports = [
      nixosModule
    ];
    services.circleci-runners.foobar = {
      enable = true;
      auth_token = "foobar";
    };
  };
  # This test only tests that the service evaluates nicely and starts.
  # The service cannot _really_ work inside a nixos vm because the api auth
  # token needs to be set.
  testScript = ''
    machine.start()
    machine.wait_for_unit("multi-user.target")
    machine.wait_for_unit("circleci-runner-foobar.service")
  '';
})
