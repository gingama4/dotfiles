{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation rec {
  pname = "gh-q";
  name = pname;
  src = fetchFromGitHub {
    owner = "kawarimidoll";
    repo = "gh-q";
    rev = "5dc627f350902e0166016a9dd1f9479c75e3f392";
    hash = "sha256-A0xYze0LCA67Qmck3WXiUihchLyjbOzWNQ++mitf3bk=";
  };
  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    sed 1d $src/gh-q > $out/bin/gh-q
    sed -i "1i#!\/usr\/bin\/env sh" $out/bin/gh-q
    chmod +x $out/bin/gh-q
  '';
}
