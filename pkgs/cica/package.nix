{
  lib,
  stdenvNoCC,
  fetchzip,
  withEmoji ? true,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "cica";
  version = "5.0.3";

  src =
    if withEmoji then
      fetchzip {
        url = "https://github.com/miiton/Cica/releases/download/v${finalAttrs.version}/Cica_v${finalAttrs.version}.zip";
        hash = "sha256-BtDnfWCfD9NE8tcWSmk8ciiInsspNPTPmAdGzpg62SM=";
        stripRoot = false;
      }
    else
      fetchzip {
        url = "https://github.com/miiton/Cica/releases/download/v${finalAttrs.version}/Cica_v${finalAttrs.version}_without_emoji.zip";
        hash = "sha256-0EnVosRYK0bkeIwv0dl2E978p+KrqffwvsDo4DGFCwA=";
        stripRoot = false;
      };

  installPhase = ''
    runHook preInstall

    install -Dm644 *.ttf -t $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = {
    description = "Composite font of Hack, DejaVu Sans Mono, and Rounded Mgen+";
    homepage = "https://github.com/miiton/Cica";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
  };
})
