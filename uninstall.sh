waitUntilBootCompleted() {
    resetprop -w sys.boot_completed 0 && return
    while [[ $(getprop sys.boot_completed) -eq 0 ]]; do
        sleep 10
    done
}

(
waitUntilBootCompleted
sleep 3
pm uninstall app.vanadium.browser 2>/dev/null
pm uninstall app.vanadium.webview 2>/dev/null
pm uninstall app.vanadium.trichromelibrary 2>/dev/null
) &
