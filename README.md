# Vanadium WebView & Browser Installer

This module changes your system WebView with Vanadium WebView and installs the Vanadium Browser.

## Features
- Installs Vanadium Trichrome Library
- Installs Vanadium WebView
- Installs Vanadium Browser
- Works with Magisk and KernelSU
- Automatically debloats conflicting packages.

## What is this project?
A Magisk/KernelSU module that changes your system WebView implementation to Vanadium WebView and installs the Vanadium Browser.

## Prerequisites
- Android 10+ (API level 29 or higher)
- Magisk or KernelSU installed
- Internet connection (Wi-Fi recommended)

## Known Issues
- Curl may fail to download over mobile data. Use Wi-Fi if possible.
- Google Trichrome Library may not always uninstall automatically, so you might need to remove it manually.

## Installation Guide
1. Download the latest release of this module.
2. Flash it in Magisk or KernelSU.
3. Reboot your device.

## Credits
- Original module: WebViewChanger by Lordify (https://gitlab.com/Lordify/webview-changer)
- Vanadium by GrapheneOS (GPL-2.0-only)
- topjohnwu – for Magisk
- Tiann – for KernelSU
- Zackptg5 – for MMT-Extended
- F3FFO – for Open WebView module
- Current fork modifications: **NoneBaiano**

## License
This project is a derivative of Vanadium (GrapheneOS), which is licensed under the **GNU General Public License v2.0 ONLY**.

As required by the upstream license, this module is also distributed under **GPL-2.0-only**.

You must include the official GPL-2.0 license text in the `LICENSE` file.

The official GPL-2.0-only license text is available at:  
https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt
