{ stdenv, system }:
let
  version = "1.0.43778-64ef58f";
  systemMapping = {
    "x86_64-linux" = "linux/amd64";
  };
  systemPath = systemMapping.${system};
in
stdenv.mkDerivation {
  name = "circleci-launch-agent";
  src = builtins.fetchurl {
    url = "https://circleci-binary-releases.s3.amazonaws.com/circleci-launch-agent/${version}/${systemPath}/circleci-launch-agent";
    sha256 = "1yhd835m1idvgfw1qhl0aplsm8zaisv9br7xi2pkz8rh7nq0f4cd";
  };
  buildCommand = ''
    mkdir -p $out/bin
    cp $src $out/bin/circleci-launch-agent
    chmod +x $out/bin/circleci-launch-agent
  '';
}
