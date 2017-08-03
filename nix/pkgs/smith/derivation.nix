{ stdenv, lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name = "smith-${version}";
  version = "1.1.2";
  rev = "v${version}";

  goPackagePath = "github.com/oracle/smith";

  src = fetchFromGitHub {
    owner = "oracle";
    repo = "smith";
    inherit rev;
    sha1 = "50dihx6sx0ys5h3v05r47804d8ww6vqm";
  };

  meta = with stdenv.lib; {
    description = "smith is a simple command line utility for building microcontainers from rpm packages or oci images.";
    homepage = https://github.com/oracle/smith;
    platforms = platforms.linux ++ platforms.darwin;
    license = [ licenses.asl20 licenses.upl ];
    maintainers = with maintainers; [ tteggel ];
 };
}