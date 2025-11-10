MODDIR=${0%/*}

source "$MODDIR/debloat.sh"

if [[ "$KSU" ]]; then
  # Use o caminho real do módulo em vez de hardcode "WVC"
  MODULE_PATH="/data/adb/modules/$(basename "$MODDIR")"
  [ -n "$pkg1" ] && setfattr -n trusted.overlay.opaque -v y "$MODULE_PATH/$pkg1"
  [ -n "$pkg2" ] && setfattr -n trusted.overlay.opaque -v y "$MODULE_PATH/$pkg2"
  [ -n "$pkg3" ] && setfattr -n trusted.overlay.opaque -v y "$MODULE_PATH/$pkg3"
  [ -n "$pkg4" ] && setfattr -n trusted.overlay.opaque -v y "$MODULE_PATH/$pkg4"
  [ -n "$pkg5" ] && setfattr -n trusted.overlay.opaque -v y "$MODULE_PATH/$pkg5"
  [ -n "$pkg6" ] && setfattr -n trusted.overlay.opaque -v y "$MODULE_PATH/$pkg6"
fi
