#!/system/bin/sh
# ============================================================================
# WVC-Vanadium02 Installer (v7.8)
# Instala Vanadium WebView, TrichromeLibrary e Browser
# ============================================================================

# Extrair curl direto em /bin (sem subpasta arm64/)
if [[ "$ARCH" = "arm" ]]; then
	unzip -j "$MODPATH/bin/curl.zip" -d "$MODPATH/bin"
elif [[ "$ARCH" = "arm64" ]]; then
	unzip -j "$MODPATH/bin/curl64.zip" -d "$MODPATH/bin"
else
	echo "Unsupported CPU Architecture"
	exit
fi

chmod 0755 "$MODPATH/bin/curl"

# Alias para Curl
alias curl="$MODPATH/bin/curl --dns-servers 1.1.1.1,1.0.0.1"

# Variáveis
local LOS=$(getprop | grep -o -c "lineage")

# API Check
if [[ $API -ge 29 ]]; then
	echo "Your Android Version is Supported!"
else
	abort "Your Android Version is not Supported!"
fi

# ARCH Check
if [[ "$ARCH" = "arm64" || "$ARCH" = "arm" ]]; then
	echo "Your CPU Architecture is Supported!"
else
	abort "Your CPU Architecture is not Supported!"
fi

# Custom ROM Check
if [[ $LOS -gt 0 ]]; then
	TLP=/system/product/app/VanadiumTrichromeLibrary
	WVP=/system/product/app/VanadiumWebView
	BRP=/system/product/app/VanadiumBrowser
	echo "LineageOS Based Custom ROM Detected!"
else
	TLP=/system/app/VanadiumTrichromeLibrary
	WVP=/system/app/VanadiumWebView
	BRP=/system/app/VanadiumBrowser
fi

mkdir -p "$MODPATH/$TLP"
mkdir -p "$MODPATH/$WVP"
mkdir -p "$MODPATH/$BRP"

# === URLs ===
TRI_URL="https://gitlab.com/grapheneos/platform_external_vanadium/-/raw/2025110600/prebuilt/arm64/TrichromeLibrary.apk"
WEB_URL="https://gitlab.com/grapheneos/platform_external_vanadium/-/raw/2025110600/prebuilt/arm64/TrichromeWebView.apk"
BRW_URL="https://gitlab.com/grapheneos/platform_external_vanadium/-/raw/2025110600/prebuilt/arm64/TrichromeChrome.apk"

# ============================================================================
# 🧱 DOWNLOAD E INSTALAÇÃO
# ============================================================================

echo "Downloading and Installing Vanadium TrichromeLibrary..."
curl -o "$MODPATH/$TLP/VanadiumTrichromeLibrary.apk" "$TRI_URL"
if [[ -f "$MODPATH/$TLP/VanadiumTrichromeLibrary.apk" ]]; then
	su -c cp "$MODPATH/$TLP/VanadiumTrichromeLibrary.apk" /data/local/tmp
	su -c pm install --install-location 1 /data/local/tmp/VanadiumTrichromeLibrary.apk
else
	abort "Couldn't Download TrichromeLibrary!"
fi

echo "Downloading and Installing Vanadium WebView..."
curl -o "$MODPATH/$WVP/VanadiumWebView.apk" "$WEB_URL"
if [[ -f "$MODPATH/$WVP/VanadiumWebView.apk" ]]; then
	su -c cp "$MODPATH/$WVP/VanadiumWebView.apk" /data/local/tmp
	su -c pm install --install-location 1 /data/local/tmp/VanadiumWebView.apk
	echo "Vanadium WebView Installed!"
else
	abort "Couldn't Download WebView!"
fi

echo "Downloading and Installing Vanadium Browser..."
curl -o "$MODPATH/$BRP/VanadiumBrowser.apk" "$BRW_URL"
if [[ -f "$MODPATH/$BRP/VanadiumBrowser.apk" ]]; then
	su -c cp "$MODPATH/$BRP/VanadiumBrowser.apk" /data/local/tmp
	su -c pm install --install-location 1 /data/local/tmp/VanadiumBrowser.apk
	echo "Vanadium Browser Installed!"
else
	abort "Couldn't Download Browser!"
fi

# ============================================================================
# 🔍 OVERLAY
# ============================================================================
echo "Checking for Overlay Directory..."
if [[ $LOS -gt 0 ]]; then
	OVERLAY_PATH=system/product/overlay/
elif [[ -d /system/product/overlay ]]; then
	OVERLAY_PATH=system/product/overlay/
elif [[ -d /system_ext/overlay ]]; then
	OVERLAY_PATH=system/system_ext/overlay/
elif [[ -d /system/overlay ]]; then
	OVERLAY_PATH=system/overlay/
elif [[ -d /system/vendor/overlay ]]; then
	OVERLAY_PATH=system/vendor/overlay/
else
	abort "Unable to Find a Correct Overlay Path!"
fi
echo "Overlay Directory Found!"

echo "Creating Overlay Directory Inside the Module..."
mkdir -p "$MODPATH/$OVERLAY_PATH"
cp "$MODPATH/Overlay/WebViewOverlay29.apk" "$MODPATH/$OVERLAY_PATH/WebViewOverlay.apk"

# ============================================================================
# 🧹 LIMPEZA
# ============================================================================
echo "Cleaning Up..."
rm -rf "$MODPATH/bin/"*.zip
rm -rf "$MODPATH/system/.placeholder"
rm -rf "$MODPATH/Overlay"
rm -rf "$MODPATH/common"

# Registrar pacotes instalados
echo "WV1=app.vanadium.trichromelibrary" >> "$MODPATH/debloat.sh"
echo "WV2=app.vanadium.webview" >> "$MODPATH/debloat.sh"
echo "WV3=app.vanadium.browser" >> "$MODPATH/debloat.sh"

echo "Trichrome Library, Vanadium System WebView and Vanadium Browser Installed Successfully!"

