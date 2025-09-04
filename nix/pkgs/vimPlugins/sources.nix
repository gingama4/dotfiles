{
  fetchurl,
  fetchFromGitHub,
}:
{
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

