# Yazi Learnings

Notes gathered while installing and setting up **Yazi** — a fast terminal file manager written in Rust — on this Windows (wezterm) machine.

Date: 2026-10-01

## What was installed

All packages were installed via **winget** (already present; no scoop/cargo needed).

| Tool | Package ID | Version | Purpose |
|------|-----------|---------|---------|
| Yazi | `sxyazi.yazi` | 26.9.1 | The file manager itself |
| fd | `sharkdp.fd` | 10.5.0 | Fast file searching (used by yazi's built-in search) |
| ripgrep (rg) | `BurntSushi.ripgrep.MSVC` | 15.2.0 | Code/pattern search (`features:+pcre2`) |
| fzf | `junegunn.fzf` | 0.74.4 | Fuzzy finding integration |

### Install commands

```powershell
winget install --id sxyazi.yazi -e --accept-source-agreements --accept-package-agreements
winget install --id sharkdp.fd -e --accept-source-agreements --accept-package-agreements
winget install --id BurntSushi.ripgrep.MSVC -e --accept-source-agreements --accept-package-agreements
winget install --id junegunn.fzf -e --accept-source-agreements --accept-package-agreements
```

**Notes on choice:**
- Winget resolved to official GitHub release zips (MSVC build for Windows).
- Installed `BurntSushi.ripgrep.MSVC` (not the `GNU` variant) — the MSVC build is the right one for native Windows without the MSYS runtime.
- A choco alternative existed (`choco install yazi`), but winget was used since it's built in and cleaner.
- Winget adds `Command line alias` entries. Two aliases were added for yazi: `yazi` and `ya` (the quick `ya` shortcut).

## PATH / how binaries resolve

- Winget places each tool's real `.exe` under:
  `%LOCALAPPDATA%\Microsoft\WinGet\Packages\<PackageId>_Microsoft.Winget.Source_8wekyb3d8bbwe\<subfolder>`
- The installer appends these package folders (not a Links shim dir) directly to the **user** PATH. Verified:
  ```
  C:\Users\AliFa\AppData\Local\Microsoft\WinGet\Packages\sxyazi.yazi_...\yazi-x86_64-pc-windows-msvc
  ...\sharkdp.fd_...\fd-v10.5.0-x86_64-pc-windows-msvc
  ...\BurntSushi.ripgrep.MSVC_...\ripgrep-15.2.0-x86_64-pc-windows-msvc
  ...\junegunn.fzf_...
  ```
- **Important:** PATH changes made by winget only apply to *newly launched* processes. A current/old shell (or the session where installs ran) still has a stale PATH — you must **open a new terminal window** before `yazi` will resolve.

## Verification

Confirmed working versions with direct-path execution:

```
yazi  26.9.1  (x86_64-pc-windows-msvc)
fd    10.5.0
rg    15.2.0  (PCRE2 enabled)
fzf   0.74.4
```

## Runtime config location (Windows)

Yazi keeps its config in `%APPDATA%\yazi` (i.e. `C:\Users\AliFa\AppData\Roaming\yazi`):

```
%APPDATA%\yazi\config\yazi.toml    # main configuration
%APPDATA%\yazi\config\keymap.toml  # keybindings (optional overrides)
%APPDATA%\yazi\config\theme.toml   # theme overrides (optional)
%APPDATA%\yazi\state\              # state data, plugins, etc.
```

This folder is auto-created on first run. Config entries are optional; Yazi ships sensible defaults and merges whatever you define on top.

## WezTerm integration

- Yazi is a pure TUI and runs unchanged inside WezTerm.
- Runs at full color/image support natively (wezterm supports the protocols yazi uses for image previews).
- Seamless combo: launch `yazi` in a wezterm tab; use keybindings to open files in your editor and to preview images/video text without extra config.
- A common pattern is binding `ctrl+t` (open yazi and then `cd` into the directory you leave it in) via a shell function in `.zshrc`/PowerShell profile, e.g.:

  ```powershell
  # PowerShell profile (~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1)
  function y { $p = yazi; if ($p) { Set-Location $p } }
  ```

## Starter config

A minimal starter `yazi.toml` is included in this folder under `config/yazi.toml` as a reference. There was no existing user config to copy, since yazi had not been launched yet.

## Tips learned

- `ya` is a shorter alias added by winget for `yazi`.
- Yazi `--help` is comprehensive; `--debug` prints a diagnostic report (config paths, environment, version info) handy for support.
- Because fd/rg/fzf are on PATH, yazi's search (`f`), global search (`Ctrl+G` style filtering), and fuzzy file discovery work out of the box.
- Keep yazi updated the same way it was installed: `winget upgrade sxyazi.yazi`.
- Image preview quality in wezterm depends on the wezterm version; recent WezTerm supports kitty-graphics, which yazi uses automatically when available.