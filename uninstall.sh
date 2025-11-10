MODDIR=${0%/*}

source $MODDIR/debloat.sh

# Esperar o boot do sistema
waitUntilBootCompleted() {
    resetprop -w sys.boot_completed 0 && return
    while [[ $(getprop sys.boot_completed) -eq 0 ]]; do
        sleep 10
    done
}

# Desinstalar em ordem segura (browser → webview → trichrome library)
(
waitUntilBootCompleted
sleep 3

# Desinstala o Vanadium Browser primeiro
pm uninstall $WV3 2>/dev/null

# Depois o WebView
pm uninstall $WV2 2>/dev/null

# Por último o TrichromeLibrary (dependência)
pm uninstall $WV1 2>/dev/null

) &
