{
  lib,
  slstatus,
  withBattery ? false,
}:

slstatus.override {
  patches = [
    ./slstatus-1.1-config.patch
  ]
  ++ lib.optional withBattery ./slstatus-1.1-battery.patch;
}
