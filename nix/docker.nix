{ pkgs, ogmios-exe }:

pkgs.dockerTools.buildLayeredImage {
  name = "jefdaj/ogmios-nix";
  tag = "latest";

  contents = [ ogmios-exe ];

  config = {
    Entrypoint = [ "/bin/ogmios" ];
    ExposedPorts = { "1337/tcp" = { }; };
    StopSignal = "SIGINT";
    Labels = {
      name = "ogmios";
      description = "A JSON WebSocket bridge for cardano-node.";
    };
    Healthcheck = {
      Test = [ "CMD" "/bin/ogmios" "health-check" ];
      Interval = 10000000000;
      Timeout = 5000000000;
      Retries = 1;
    };
  };
}
