# Restart QuickLook

rm -f ~/Library/Containers/com.apple.quicklook.ui.helper/Data/Library/Preferences/com.apple.quicklook.ui.helper.plist
rm -f ~/Library/Preferences/com.apple.QuickLookDaemon.plist
qlmanage -r cache
qlmanage -r
