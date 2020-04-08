{ stdenv, fetchurl }:

let  

  fonts = [
    { name = "MesloLGS NF Regular"; hash = "sha256:1jydmjlhssvmj0ddy7vzn0cp6wkdjk32lvxq64wrgap8q9xy14li"; }
    { name = "MesloLGS NF Bold"; hash = "sha256:0w9byh20804qscsj13wj9v3llaqqzbkg5dmpwf0yqmxcvgs8dp7b"; }
    { name = "MesloLGS NF Italic"; hash = "sha256:1442jp3zh92fz7fs5xn4853djnbchkqj7i09avnhpgp9bbn07fzz"; }
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
