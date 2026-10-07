{ ... }:
{
  flake.nixosModules.hardwareEnable =
    { pkgs, ... }:
    {
      hardware = {
        graphics = {
          enable = true;
          enable32Bit = true;
          extraPackages = with pkgs; [
            rocmPackages.clr.icd
          ];
        };
        amdgpu.initrd.enable = true;
      };
    };
}
