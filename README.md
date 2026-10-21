# KOReader Share External Link

Share a book's external links through Android's native share menu directly from KOReader.

Tap an external link, then tap **Share** in the external-link dialog. Choose an installed app to receive the URL as plain text.

## Features

- Adds **Share** alongside KOReader's existing external-link actions.
- Opens Android's native share chooser.
- Preserves existing buttons and actions, including those registered by plugins.
- Applies to each newly opened book.

## Requirements

- KOReader on Android with user patches enabled.
- A recent KOReader version providing `ReaderLink:addToExternalLinkDialog` and `Device:doShareText`.
- On Android, use the official **rocks** build. F-Droid builds disable user patches.
- Confirmed working by a user on a **Boox Palma 2**, including opening the Android share menu. Other devices have not been tested.

The patch does nothing on non-Android devices or devices without text-sharing support.

## Install manually

1. Download [2-share-external-link.lua](https://raw.githubusercontent.com/Kageetai/koreader-share-external-link/main/2-share-external-link.lua).
2. Copy it into KOReader's `patches` folder, usually `Internal storage/koreader/patches` on Android. Create the folder if needed.
3. Fully exit KOReader and reopen it.
4. Open a book, tap an external link, and tap **Share**.

Keep the filename, including the `2-` prefix and `.lua` extension. To update, replace the existing file and restart KOReader. To uninstall, delete the file and restart.

### Install using ADB

With USB debugging enabled and your computer authorized on the device, run these commands from the folder containing the downloaded patch.

PowerShell:

```powershell
adb shell mkdir -p /sdcard/koreader/patches
adb push "2-share-external-link.lua" /sdcard/koreader/patches/
```

Git Bash on Windows:

```bash
MSYS_NO_PATHCONV=1 adb shell mkdir -p /sdcard/koreader/patches
MSYS_NO_PATHCONV=1 adb push "2-share-external-link.lua" /sdcard/koreader/patches/
```

`MSYS_NO_PATHCONV=1` prevents Git Bash from rewriting the Android destination as a Windows path. Adjust the destination if your KOReader data folder is elsewhere, then restart KOReader.

## Storefront and App Store

This public repository uses the **`koreader-user-patch`** topic and keeps its numbered Lua patch at the repository root for discovery and installation by community stores.

In Storefront or App Store, refresh the patches catalog and search for **koreader-share-external-link**. Listing depends on GitHub indexing, the store's catalog rebuild, and its local cache refresh; it may not appear immediately.

If your store supports installation or matching by repository URL, use:

```text
https://github.com/Kageetai/koreader-share-external-link
```

If you installed the file manually, use the store's repository-matching feature, where available, to associate it with this repository for update checks. Compatibility with every third-party store is not guaranteed.

Discovery references: [Storefront catalog builder](https://github.com/ultimatejimmy/storefront.koplugin/blob/main/tools/build_catalog.py) and [App Store patch installation](https://github.com/omer-faruq/appstore.koplugin#patches-browser-app-store--patches).

## Notes

- Shares the external URL, without adding the book title or surrounding passage.
- Closes KOReader's link dialog before opening the Android share chooser.
- Existing buttons may move when the new button is added.
- Other patches that replace `ReaderLink:init` without calling the original method may conflict.
- This is a KOReader user patch, distributed through KOReader community stores; it is not a standalone Android application.

## Implementation and verification

Wraps `ReaderLink:init`, calls the original initializer, and registers an additional button through `addToExternalLinkDialog`. The button calls `Device:doShareText` on the next UI tick after closing the external-link dialog.

The initial patch was checked against upstream KOReader source and subsequently confirmed working on a Boox Palma 2. This repository packages that same patch without changing its behavior.

## License

MIT. See [LICENSE](LICENSE).
