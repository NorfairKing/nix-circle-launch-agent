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
    };
  };
  testScript = ''
    machine.start()
    machine.wait_for_unit("multi-user.target")
  '';
})
