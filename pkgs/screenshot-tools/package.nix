{
  lib,
  symlinkJoin,
  writeShellApplication,
  coreutils,
  scrot,
  xclip,
}:

let
  screenshot = writeShellApplication {
    name = "screenshot";

    runtimeInputs = [
      coreutils
      scrot
    ];

    excludeShellChecks = [ "SC2016" ];

    text = ''
      exec scrot --file=/tmp/screenshot-%Y%m%dT%H%M%S%z.png \
        --exec='mkdir -p ~/Pictures/Screenshots && mv $f ~/Pictures/Screenshots/' \
        "$@"
    '';
  };

  screenshot-to-clipboard = writeShellApplication {
    name = "screenshot-to-clipboard";

    runtimeInputs = [
      scrot
      xclip
    ];

    excludeShellChecks = [ "SC2016" ];

    text = ''
      exec scrot --file=/tmp/screenshot-%Y%m%dT%H%M%S%z.png \
        --exec='xclip -selection clipboard -target image/png $f' \
        "$@"
    '';
  };
in
symlinkJoin {
  pname = "screenshot-tools";
  version = "0.1.0";

  paths = [
    screenshot
    screenshot-to-clipboard
  ];

  meta = {
    description = "Custom screenshot tools using scrot";
    license = lib.licenses.unlicense;
    platforms = lib.platforms.linux;
  };
}
