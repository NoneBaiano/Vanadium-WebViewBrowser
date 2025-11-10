echo
echo "***************"
echo "Checking API..."
echo "***************"
echo

# API Check
if [[ $API -ge 29 ]]; then
    echo "Your Android Version is Supported!"
else
    abort "Your Android Version is not Supported!"
fi

echo
echo "****************"
echo "Checking Arch..."
echo "****************"
echo

# Arch Check
if [[ "$ARCH" = "arm" ]]; then
    echo "Your Architectrue is Supported!"
elif [[ "$ARCH" = "arm64" ]]; then
    echo "Your Architecture is Supported!"
else
    abort "Your Architecture is not Supported!"
fi

echo
echo "************"
echo "Debloating..."
echo "************"
echo

# Uninstall Updates of Conflicting Packages
echo "Checking and Uninstalling Any Updated Conflicting Packages..."
#upkg1
upkg1=$(pm dump com.android.chrome | grep "codePath=/data" | grep -o "/.*")
if [[ -d "$upkg1" ]]; then
	echo "Updated Chrome Found! Uninstalling Update..."
	pm uninstall com.android.chrome
fi
#upkg2
upkg2=$(pm dump com.android.webview | grep "codePath=/data" | grep -o "/.*")
if [[ -d "$upkg2" ]]; then
	echo "Updated AOSP WebView Found! Uninstalling Update..."
	pm uninstall com.android.webview
fi
#upkg3
upkg3=$(pm dump com.google.android.webview | grep "codePath=/data" | grep -o "/.*")
if [[ -d "$upkg3" ]]; then
	echo "Updated Google WebView Found! Uninstalling Update..."
	pm uninstall com.google.android.webview
fi
#upkg4
upkg4=$(pm dump org.mozilla.webview_shell | grep "codePath=/data" | grep -o "/.*")
if [[ -d "$upkg4" ]]; then
	echo "Updated Mozilla WebView Found! Uninstalling Update..."
	pm uninstall org.mozilla.webview_shell
fi
#upkg5
upkg5=$(pm dump com.sec.android.app.chromecustomizations | grep "codePath=/data" | grep -o "/.*")
if [[ -d "$upkg5" ]]; then
	echo "Updated Chrome Customization Found! Uninstalling Update..."
	pm uninstall com.sec.android.app.chromecustomizations
fi
#upkg6
upkg6=$(pm dump com.google.android.trichromelibrary | grep "codePath=/data" | grep -o "/.*")
if [[ -d "$upkg6" ]]; then
	echo "Updated Google TrichromeLibrary Found! Uninstalling Update..."
	pm uninstall com.google.android.trichromelibrary
fi

# Checking for Conflicting Packages
echo "Checking and Debloating Conflicting Packages..."
if [[ "$KSU" ]]; then
echo "Installing from KernelSU..."
	# pkg1
	pkg1=$(pm dump com.android.chrome | grep "codePath" | grep -o "/.*")
	if [[ -d "$pkg1" ]]; then
	mkdir -p $MODPATH/$pkg1
		echo "Chrome Systemlessly Debloated!"
		echo "pkg1=$pkg1" >> $MODPATH/debloat.sh
	else
		echo "Chrome Not Found!"
	fi
	# pkg2
	pkg2=$(pm dump com.android.webview | grep "codePath" | grep -o "/.*")
	if [[ -d "$pkg2" ]]; then
	mkdir -p $MODPATH/$pkg2
		echo "AOSP WebView Systemlessly Debloated!"
		echo "pkg2=$pkg2" >> $MODPATH/debloat.sh
	else
		echo "AOSP WebView Not Found!"
	fi
	# pkg3
	pkg3=$(pm dump com.google.android.webview | grep "codePath" | grep -o "/.*")
	if [[ -d "$pkg3" ]]; then
	mkdir -p $MODPATH/$pkg3
		echo "Google WebView Systemlessly Debloated!"
		echo "pkg3=$pkg3" >> $MODPATH/debloat.sh
	else
		echo "Google Webview Not Found!"
	fi
	# pkg4
	pkg4=$(pm dump org.mozilla.webview_shell | grep "codePath" | grep -o "/.*")
	if [[ -d "$pkg4" ]]; then
	mkdir -p $MODPATH/$pkg4
		echo "Mozilla WebView Systemlessly Debloated!"
		echo "pkg4=$pkg4" >> $MODPATH/debloat.sh
	else
		echo "Mozilla WebView Not Found!"
	fi
	# pkg5
	pkg5=$(pm dump com.sec.android.app.chromecustomizations | grep "codePath" | grep -o "/.*")
	if [[ -d "$pkg5" ]]; then
	mkdir -p $MODPATH/$pkg5
		echo "Chrome Customization Systemlessly Debloated!"
		echo "pkg5=$pkg5" >> $MODPATH/debloat.sh
	else
		echo "Chrome Customization Not Found!"
	fi
	# pkg6
	pkg6=$(pm dump com.google.android.trichromelibrary | grep "codePath" | grep -o "/.*")
	if [[ -d "$pkg6" ]]; then
	mkdir -p $MODPATH/$pkg6
		echo "Google TrichromeLibrary Systemlessly Debloated!"
		echo "pkg6=$pkg6" >> $MODPATH/debloat.sh
	else
		echo "Google TrichromeLibrary Not Found!"
	fi
else
echo "Installing from Magisk..."
	# pkg1
	pkg1=$(pm dump com.android.chrome | grep "codePath" | grep -o "/.*")
	if [[ -d "$pkg1" ]]; then
	mktouch $MODPATH/$pkg1/.replace
		echo "Chrome Systemlessly Debloated!"
	else
		echo "Chrome Not Found!"
	fi
	# pkg2
	pkg2=$(pm dump com.android.webview | grep "codePath" | grep -o "/.*")
	if [[ -d "$pkg2" ]]; then
	mktouch $MODPATH/$pkg2/.replace
		echo "AOSP WebView Systemlessly Debloated!"
	else
		echo "AOSP WebView Not Found!"
	fi
	# pkg3
	pkg3=$(pm dump com.google.android.webview | grep "codePath" | grep -o "/.*")
	if [[ -d "$pkg3" ]]; then
	mktouch $MODPATH/$pkg3/.replace
		echo "Google WebView Systemlessly Debloated!"
	else
		echo "Google Webview Not Found!"
	fi
	# pkg4
	pkg4=$(pm dump org.mozilla.webview_shell | grep "codePath" | grep -o "/.*")
	if [[ -d "$pkg4" ]]; then
	mktouch $MODPATH/$pkg4/.replace
		echo "Mozilla WebView Systemlessly Debloated!"
	else
		echo "Mozilla WebView Not Found!"
	fi
	# pkg5
	pkg5=$(pm dump com.sec.android.app.chromecustomizations | grep "codePath" | grep -o "/.*")
	if [[ -d "$pkg5" ]]; then
	mktouch $MODPATH/$pkg5/.replace
		echo "Chrome Customization Systemlessly Debloated!"
	else
		echo "Chrome Customization Not Found!"
	fi
	# pkg6
	pkg6=$(pm dump com.google.android.trichromelibrary | grep "codePath" | grep -o "/.*")
	if [[ -d "$pkg6" ]]; then
	mktouch $MODPATH/$pkg6/.replace
		echo "Google TrichromeLibrary Systemlessly Debloated!"
	else
		echo "Google TrichromeLibrary Not Found!"
	fi
fi

# Manually Handle /product to Avoid Problems
prod=$MODPATH/product
if [[ -d "$prod" ]]; then
echo "Manually Handle /product Partition..."
	mkdir -p $MODPATH/system/product
	cp -a $prod/* $MODPATH/system/product
	rm -rf $prod
fi

# Manually Handle /vendor to Avoid Problems
vend=$MODPATH/vendor
if [[ -d "$ven" ]]; then
echo "Manually Handle /vendor Partition..."
	mkdir -p $MODPATH/system/vendor
	cp -a $ven/* $MODPATH/system/vendor
	rm -rf $ven
fi

# Manually Handle /system_ext to Avoid Problems
sysext=$MODPATH/system_ext
if [[ -d "$sysext" ]]; then
echo "Manually Handle /system_ext Partition..."
	mkdir -p $MODPATH/system/system_ext
	cp -a $sysext/* $MODPATH/system/system_ext
	rm -rf $sysext
fi

# Install
echo
echo "**********"
echo "Installing..."
echo "**********"
echo

[ -f "$MODPATH/common/install.sh" ] && . $MODPATH/common/install.sh