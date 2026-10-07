{ ... }:
{
  flake.nixosModules.users =
    { pkgs, ... }:
    {
      users.users.muiga = {
        isNormalUser = true;
        description = "muiga";
        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
          "video"
          "render"
        ];
        shell = pkgs.zsh;
      };
    };
}
