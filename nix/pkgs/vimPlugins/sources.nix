{
  fetchurl,
  fetchFromGitHub,
}:
{
  skkeleton = {
    pname = "skkeleton";
    version = "f1f0586c69d84c6ee5f3e5a4ca76cc188161b944";
    src = fetchFromGitHub {
      owner = "vim-skk";
      repo = "skkeleton";
      rev = "f1f0586c69d84c6ee5f3e5a4ca76cc188161b944";
      fetchSubmodules = false;
      sha256 = "sha256-egAD1VDmoks9WwsEMOgyJmiMRV+p4f6S4sWOMKAew48=";
    };
    date = "2025-02-09";
  };
  cmp-skkeleton = {
    pname = "cmp-skkeleton";
    version = "ae74491bc73b868c60f69e4362d3bea29a6bf74d";
    src = fetchFromGitHub {
      owner = "rinx";
      repo = "cmp-skkeleton";
      rev = "ae74491bc73b868c60f69e4362d3bea29a6bf74d";
      fetchSubmodules = false;
      sha256 = "sha256-QTknfchb9Z10Xn8JmJTRqknVu+qgXPayc/zQIBK1B5E=";
    };
    date = "2024-01-05";
  };
  vimdoc-ja = {
    pname = "vimdoc-ja";
    version = "7492a35449191172e216c8c1f43bce3f1ad430f6";
    src = fetchFromGitHub {
      owner = "vim-jp";
      repo = "vimdoc-ja";
      rev = "7492a35449191172e216c8c1f43bce3f1ad430f6";
      fetchSubmodules = false;
      sha256 = "sha256-P4krg7p7uvmIWu7zBRoyRGq4gpaLQj76NIef90NSqiw=";
    };
    date = "2025-03-11";
  };
}

