### macOS Defaults
<!-- halpme: macos | System preferences applied by sane-macos-defaults.sh -->

Applied by `bin/sane-macos-defaults.sh` during bootstrap. Re-run any time — all idempotent.

```bash
~/bin/sane-macos-defaults.sh
```

**General UI/UX:** boot sound off, scrollbars always visible, save panels expanded, no iCloud default save, app resume off, auto-correct/capitalize/dashes/quotes all off

**Trackpad & Keyboard:** tap to click, two-finger right-click, fast key repeat (rate 2, delay 15), press-and-hold off

**Energy:** wake on lid open, auto-restart on power loss or freeze, display sleep 15 min

**Screen & Screenshots:** password required immediately after sleep, screenshots to `~/Screenshots` as PNG, no drop shadow

**Finder:** hidden files shown, all extensions shown, path bar visible, full POSIX path in title, folders sorted to top, search defaults to current folder, list view default

**Dock:** 70px icons, scale minimize, auto-hide no delay, recent apps shown, no opening animation, bottom-right hot corner starts screensaver

**Spotlight:** ⌘Space and ⌥⌘Space shortcuts disabled (Raycast claims them)

**Safari:** configure manually in Safari's UI — `defaults write` for Safari is sandboxed and ignored on macOS Sonoma and later

**iTerm:** no quit confirmation, prefs loaded from `~/.config/com.googlecode.iterm2/`

**Other:** TextEdit plain text mode, Photos won't auto-open, Time Machine won't prompt for new disks, daily software update checks

---
