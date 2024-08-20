{ pkgs, ... }: {
  kernel.python.ihdcm037 = {
    enable = true;
    displayName = "Machine Learning - UNamur IHDCM037";
    extraPackages = ps: [ ps.scikit-learn ];
  };
}
