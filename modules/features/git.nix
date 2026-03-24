{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.myGit = inputs.wrapper-modules.wrappers.git.wrap {
        inherit pkgs;
        settings = {
          enable = true;

          user = {
            name = "muiga";
            email = "muigask@gmail.com";
          };

          alias = {
            release = "!f() { git tag -a \"v$1\" -m \"Release $1\" && git push && git push --tags; }; f";
          };
        };
      };
    };
}
