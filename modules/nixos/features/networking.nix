{ ... }:
{
  flake.nixosModules.networking =
    { ... }:
    {
      networking = {
        networkmanager = {
          enable = true;
          dns = "systemd-resolved";
        };
        nameservers = [
          "1.1.1.1"
          "1.0.0.1"
        ];
        firewall = {
          enable = true;
          checkReversePath = "loose";
          trustedInterfaces = [ "tailscale0" ];
          allowedTCPPorts = [
            80
            443
            53317
          ]; # 5432 removed
          allowedUDPPorts = [ 53317 ]; # 41641 handled by openFirewall
          allowedTCPPortRanges = [
            {
              from = 50000;
              to = 51000;
            }
          ];
          allowedUDPPortRanges = [
            {
              from = 4000;
              to = 4007;
            }
            {
              from = 8000;
              to = 8010;
            }
            {
              from = 50000;
              to = 51000;
            }
          ];
        };
      };

      services.resolved = {
        enable = true;
        settings.Resolve.MulticastDNS = "no";
      };

      services.tailscale = {
        enable = true;
        openFirewall = true;
        useRoutingFeatures = "client";
        extraSetFlags = [ "--operator=muiga" ];
      };
    };
}
