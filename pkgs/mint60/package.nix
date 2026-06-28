{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  symlinkJoin,
  writeShellApplication,
  avrdude,
  coreutils,
  qmk,
}:

let
  keymap = "my_keymap";

  firmware = stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "mint60-firmware";
    version = "0.33.8";

    src = fetchFromGitHub {
      owner = "qmk";
      repo = "qmk_firmware";
      tag = finalAttrs.version;
      hash = "sha256-i2dLCDqYCXRMec/VsCUUGDjx2E/16ywuWU/FBfn9hqc=";
      fetchSubmodules = true;
    };

    nativeBuildInputs = [ qmk ];

    env.SKIP_GIT = 1;

    postPatch = ''
      mkdir -p keyboards/mint60/keymaps/${keymap}

      cp ${./keymap.c} keyboards/mint60/keymaps/${keymap}/keymap.c
      cp ${./config.h} keyboards/mint60/keymaps/${keymap}/config.h
    '';

    buildPhase = ''
      runHook preBuild

      qmk compile --keyboard=mint60 --keymap=${keymap}

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      install -Dm644 mint60_${keymap}.hex -t $out/share/mint60

      runHook postInstall
    '';
  });

  flash = writeShellApplication {
    name = "mint60-flash";

    runtimeInputs = [
      avrdude
      coreutils
    ];

    text = ''
      printf 'Waiting for /dev/ttyACM0 - Press the RESET button...'
      while [ ! -c /dev/ttyACM0 ]; do
        sleep 0.5
        printf '.'
      done
      echo

      avrdude \
        -p atmega32u4 \
        -c avr109 \
        -P /dev/ttyACM0 \
        -U flash:w:${firmware}/share/mint60/mint60_${keymap}.hex:i
    '';
  };

  flash-loop = writeShellApplication {
    name = "mint60-flash-loop";

    runtimeInputs = [
      coreutils
      flash
    ];

    text = ''
      while true; do
        mint60-flash
        echo

        while [ -c /dev/ttyACM0 ]; do
          sleep 0.5
        done
      done
    '';
  };
in
symlinkJoin {
  pname = "mint60";
  version = firmware.version;

  paths = [
    firmware
    flash
    flash-loop
  ];

  meta = {
    description = "Firmware and flashing scripts for Mint60";
    homepage = "https://qmk.fm/";
    license = lib.licenses.gpl2Plus;
    mainProgram = "mint60-flash-loop";
    platforms = lib.platforms.linux;
  };
}
