{ ... }:

{
  perSystem = { ... }:
    {
      treefmt = {
        projectRootFile = "flake.nix";
        programs = {
          nixpkgs-fmt.enable = true;
          ormolu.enable = true;
          hlint.enable = true;
          shfmt.enable = true;
          black.enable = true;
        };
      };
    };
}
