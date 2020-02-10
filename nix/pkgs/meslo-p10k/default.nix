{ stdenv, fetchurl }:

let  

  fonts = [
    { name = "MesloLGS NF Regular"; hash = "sha256:0z0iw8my46hsplmivkk8ngk25sdk85yy8g6gw4b1kx7d4ig50ndk"; }
    { name = "MesloLGS NF Bold"; hash = "sha256:15ykcb20hgbsd58mwwff7r0ni012mj7zy0b5y8c42j7i54fyg4fc"; }
    { name = "MesloLGS NF Italic"; hash = "sha256:16crzjmdp6xz0xh83sdkqzqa2npbg6q25403kzw0cpmbp13bwmji"; }
    { name = "MesloLGS NF Bold Italic"; hash = "sha256:1jad0gapg3b15zcw0p68qhmb5apf0cs187qw2n4hbzvbc3x9kpks"; }
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
