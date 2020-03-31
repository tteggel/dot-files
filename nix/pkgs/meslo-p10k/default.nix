{ stdenv, fetchurl }:

let  

  fonts = [
    { name = "MesloLGS NF Regular"; hash = "sha256:0h8v3qlgc4v32xrkjcss6qv0i6nrg6wi2za08lbzk0qmd3a3sg3p"; }
    { name = "MesloLGS NF Bold"; hash = "sha256:162d0z6skq28iv138qdiqxbznyxin78parcicvrb2lsc4nwyyn1m"; }
    { name = "MesloLGS NF Italic"; hash = "sha256:0rz029b3qnijlbl97mrz30ya7kk9grn9h0r35610c70rsic8a4ld"; }
    { name = "MesloLGS NF Bold Italic"; hash = "sha256:0g5q6my8k6aaf26sq610v9v17j3gsba63f1wv2yix48sdj3pxvbz"; }
  ];
  baseUrl = https://github.com/romkatv/powerlevel10k-media/raw/master/;
in
stdenv.mkDerivation rec {
  name = "meslo-p10k";
  srcs = map (font:
    fetchurl {
      url =  baseUrl + (builtins.replaceStrings [" "] ["%20"] font.name) + ".ttf";
      name = (builtins.replaceStrings [" "] ["-"] font.name) + ".ttf";
      hash = font.hash;
    }
  )
  fonts;

  unpackCmd = ''
    mkdir  fonts
    cp $curSrc fonts
  '';

  installPhase = ''
    install -Dt $out/share/fonts/truetype ./*.ttf
  '';
}
