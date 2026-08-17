#!/system/bin/sh

if [[ "$ARCH" = "arm" ]]; then
	unzip -j "$MODPATH/bin/curl.zip" -d "$MODPATH/bin"
else
	unzip -j "$MODPATH/bin/curl64.zip" -d "$MODPATH/bin"
fi
chmod 0755 "$MODPATH/bin/curl"
CURL_BIN="$MODPATH/bin/curl"

dl() {
	url="$1"; out="$2"; n=1
	while [[ $n -le 5 ]]; do
		if [[ $n -le 3 ]]; then
			"$CURL_BIN" --fail --location --connect-timeout 15 --retry 2 --retry-delay 3 \
				--dns-servers 1.1.1.1,1.0.0.1 -o "$out" "$url"
		else
			"$CURL_BIN" --fail --location --connect-timeout 15 --retry 2 --retry-delay 3 \
				-o "$out" "$url"
		fi
		[[ -s "$out" ]] && return 0
		rm -f "$out"
		sleep 5
		n=$((n + 1))
	done
	return 1
}

local LOS=$(getprop | grep -o -c "lineage")

if [[ $LOS -gt 0 ]]; then
	TLP=/system/product/app/VanadiumTrichromeLibrary
	WVP=/system/product/app/VanadiumWebView
	BRP=/system/product/app/VanadiumBrowser
else
	TLP=/system/app/VanadiumTrichromeLibrary
	WVP=/system/app/VanadiumWebView
	BRP=/system/app/VanadiumBrowser
fi
mkdir -p "$MODPATH/$TLP" "$MODPATH/$WVP" "$MODPATH/$BRP"

TRI_URL="https://gitlab.com/grapheneos/platform_external_vanadium/-/raw/17/prebuilt/arm64-multilib/TrichromeLibrary.apk"
WEB_URL="https://gitlab.com/grapheneos/platform_external_vanadium/-/raw/17/prebuilt/arm64-multilib/TrichromeWebView.apk"
BRW_URL="https://gitlab.com/grapheneos/platform_external_vanadium/-/raw/17/prebuilt/arm64-multilib/TrichromeChrome.apk"

ui_print "Installing TrichromeLibrary..."
dl "$TRI_URL" "$MODPATH/$TLP/VanadiumTrichromeLibrary.apk" || abort "Download failed: TrichromeLibrary"
su -c cp "$MODPATH/$TLP/VanadiumTrichromeLibrary.apk" /data/local/tmp
su -c pm install --install-location 1 /data/local/tmp/VanadiumTrichromeLibrary.apk

ui_print "Installing Vanadium WebView..."
dl "$WEB_URL" "$MODPATH/$WVP/VanadiumWebView.apk" || abort "Download failed: WebView"
su -c cp "$MODPATH/$WVP/VanadiumWebView.apk" /data/local/tmp
su -c pm install --install-location 1 /data/local/tmp/VanadiumWebView.apk

ui_print "Installing Vanadium Browser..."
dl "$BRW_URL" "$MODPATH/$BRP/VanadiumBrowser.apk" || abort "Download failed: Browser"
su -c cp "$MODPATH/$BRP/VanadiumBrowser.apk" /data/local/tmp
su -c pm install --install-location 1 /data/local/tmp/VanadiumBrowser.apk

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
	abort "No overlay partition found"
fi
mkdir -p "$MODPATH/$OVERLAY_PATH"
cp "$MODPATH/Overlay/WebViewOverlay29.apk" "$MODPATH/$OVERLAY_PATH/WebViewOverlay.apk"

rm -rf "$MODPATH/bin/"*.zip "$MODPATH/system/.placeholder" "$MODPATH/Overlay" "$MODPATH/common"
