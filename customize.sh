[[ $API -ge 29 ]] || abort "Android 10+ required"
[[ "$ARCH" = "arm" || "$ARCH" = "arm64" ]] || abort "Unsupported CPU architecture"

for part in product vendor system_ext; do
  src=$MODPATH/$part
  if [[ -d "$src" ]]; then
    mkdir -p $MODPATH/system/$part
    cp -a $src/* $MODPATH/system/$part
    rm -rf $src
  fi
done

. $MODPATH/common/install.sh

echo "After installation, go to:"
echo "1°) Settings"
echo "2°) Developer options" 
echo "3°) WebView implementation"
echo "4°) Click on Vanadium WebView"
echo "5°) Enjoy it"
echo
