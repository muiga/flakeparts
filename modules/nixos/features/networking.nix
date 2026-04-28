{ ... }:
{
  flake.nixosModules.networking =
    { pkgs, ... }:
    {
      networking = {
        networkmanager.enable = true;
        nameservers = [
          "1.1.1.1"
          "1.0.0.1"
        ];
        wireguard.enable = true;
        firewall = {
          enable = true;
          trustedInterfaces = [ "tailscale0" ];
          allowedTCPPorts = [
            80
            443
            5432
            53317
          ];
          allowedUDPPorts = [
            41641
            53317
            5353
          ];
          allowedTCPPortRanges = [
            {
              from = 1714;
              to = 1716;
            }
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
              from = 1714;
              to = 1716;
            }
            {
              from = 50000;
              to = 51000;
            }
          ];
        };
      };

      #systemd.packages = [ pkgs.cloudflare-warp ];
      #systemd.targets.multi-user.wants = [ "warp-svc.service" ];

      services.tailscale = {
        enable = true;
        extraSetFlags = [ "--operator=muiga" ];
      };
    };
}
