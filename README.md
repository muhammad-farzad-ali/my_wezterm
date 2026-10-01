# WezTerm Setup Documentation

Date: 2026-10-01

This folder documents how WezTerm was configured on this machine, what was
learned during the process, and the source files involved.

## Goal

- Font: **BlexMono Nerd Font Mono**
- Color scheme: **tokyonight_night**
- Cursor background and cursor border: **#7aa2f7**

## Final Config

Saved at `C:\Users\AliFa\.wezterm.lua` (also copied here as `wezterm.lua`):

```lua
local wezterm = require("wezterm")
local config = {}

config.color_scheme = "tokyonight_night"

config.font = wezterm.font("BlexMono Nerd Font Mono")
config.font_size = 12.0

config.colors = {
  cursor_bg = "#7aa2f7",
  cursor_border = "#7aa2f7",
}

return config
```

- `color_scheme` selects a built-in scheme (`tokyonight_night` ships with WezTerm).
- The `colors` table only overrides the entries you set; everything else falls
  through to the scheme. Here we override only the cursor colors.
- `cursor_bg` = the filled caret background; `cursor_border` = the outline around the caret.

## Key Learnings

### 1. BlexMono no longer exists upstream
- The original project `Jeroen-Beckers/BlexMono` is gone (HTTP 404 on GitHub).
- BlexMono was **never** shipped as a standalone asset in any nerd-fonts release.
- It also 404s inside `repainting/nerd-fonts` `patched-fonts/BlexMono` at every
  checked tag (v2.x and v3.x).
- Conclusion: BlexMono is a discontinued fork of IBM Plex Mono. There are no mirrors on GitHub.

### 2. The IBM Plex Mono release actually installs as "BlexMono Nerd Font Mono"
- nerd-fonts distribution for IBM Plex Mono uses the historical **Blex/Mono** branding internally.
- The files in `IBMPlexMono.zip` are named `BlexMonoNerdFontMono-*.ttf`.
- The embedded font family name reads **"BlexMono Nerd Font Mono"**.
- This is exactly the family string the user wanted, so downloading the official
  `IBMPlexMono.zip` from nerd-fonts latest release satisfies the requirement.

### 3. Per-user font install on Windows (no admin rights)
Font files belong in the per-user font directory:
`%LOCALAPPDATA%\Microsoft\Windows\Fonts`

First attempt failed because the registry value names were derived from the
**file name** (e.g. `BlexMonoNerdFontMono-Bold`). DirectWrite does not see the font then.

The registry value name must be the **font display (family/subfamily) name**, and
the value data must be the **full path** to the TTF:

```
Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Fonts
  "BlexMono Nerd Font Mono (TrueType)" = "C:\Users\AliFa\AppData\Local\Microsoft\Windows\Fonts\BlexMonoNerdFontMono-Regular.ttf"
  "BlexMono Nerd Font Mono Bold (TrueType)" = "...\BlexMonoNerdFontMono-Bold.ttf"
  ... (repeat for each weight/style)
```

### 4. Read real font names with fontTools
To get the correct display-name strings, read the `name` table with Python fontTools:

```python
from fontTools.ttLib import TTFont
t = TTFont("BlexMonoNerdFontMono-Regular.ttf")
print(t["name"].getDebugName(1))   # family
print(t["name"].getDebugName(2))   # subfamily
print(t["name"].getDebugName(4))   # full name -> use as registry value name
t.close()
```

### 5. Verify with DirectWrite, then WezTerm
- Check DirectWrite sees the family:
  `powershell` -> `[System.Windows.Media.Fonts]::SystemFontFamilies`
- Check WezTerm resolves the font (no "Unable to load a font" warning):
  `wezterm ls-fonts --text "ABCdef 123"`

Caveat on Windows: `wezterm ls-fonts` output contains NUL bytes; pipe through
`tr -d '\0'` (or `grep` handles it) so text greps work.

## Source Files in This Folder

- `wezterm.lua` — active WezTerm configuration (same as `C:\Users\AliFa\.wezterm.lua`).
- `fonts/` — the 16 TTF files of the `BlexMono Nerd Font Mono` family (Mono variant)
  extracted from the official nerd-fonts `IBMPlexMono.zip` release (latest), weights:
  Regular, Italic, Bold, Bold Italic, ExtraLight, ExtraLight Italic, Light,
  Light Italic, Medium, Medium Italic, SemiBold, SemiBold Italic, Text, Text
  Italic, Thin, Thin Italic.

To reinstall the font set on a fresh machine: copy the `.ttf` files into
`%LOCALAPPDATA%\Microsoft\Windows\Fonts` and add the corresponding `(TrueType)`
registry values under `HKCU\Software\Microsoft\Windows NT\CurrentVersion\Fonts`.