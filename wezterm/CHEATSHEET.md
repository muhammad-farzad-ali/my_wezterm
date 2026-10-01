# WezTerm Cheat Sheet

Quick reference for the most common WezTerm operations. These are the default
keybindings (`Ctrl+Shift` base on Windows/Linux, `Cmd+Shift` / `Cmd+Opt` on macOS).

## Panes (split the current tab)

| Action                      | Keys                     |
| --------------------------- | ------------------------ |
| Split pane — right          | `Ctrl+Shift+Alt+R`       |
| Split pane — down           | `Ctrl+Shift+Alt+D`       |
| Split horiz/vert interactive| `Ctrl+Shift+Alt+H` / `Ctrl+Shift+Alt+V` |
| Close active pane           | `Ctrl+Shift+W`           |
| Zoom / un-zoom active pane  | `Ctrl+Shift+Z`           |
| Toggle pane fullscreen      | `Ctrl+Shift+Space`       |

## Moving around panes

| Action            | Keys                       |
| ----------------- | -------------------------- |
| Move focus up     | `Alt+Up` / `Ctrl+Shift+Up` |
| Move focus down   | `Alt+Down` / `Ctrl+Shift+Down` |
| Move focus left   | `Alt+Left` / `Ctrl+Shift+Left` |
| Move focus right  | `Alt+Right` / `Ctrl+Shift+Right` |
| Move active pane by one (precedes a direction key) | `Ctrl+Shift+Alt+M` |

## Tabs

| Action                    | Keys              |
| ------------------------- | ----------------- |
| New tab                   | `Ctrl+Shift+T`    |
| Close current tab         | `Ctrl+Shift+W`    |
| Cycle to next/prev tab    | `Ctrl+Tab` / `Ctrl+Shift+Tab` |
| Jump to tab 1..9          | `Ctrl+Alt+1`..`9` |
| Show tab bar / switcher   | `Ctrl+Shift+L` (list) then arrows |

## Search & copy

| Action                     | Keys                 |
| -------------------------- | -------------------- |
| Open scrollback search     | `Ctrl+Shift+F`       |
| Copy current selection     | `Ctrl+Shift+C`       |
| Paste                      | `Ctrl+Shift+V`       |
| Quick select (regex URLs/paths) | `Ctrl+Shift+Space` |
| Clear scrollback           | `Ctrl+Shift+K`       |

## Font size / zooming

| Action                  | Keys              |
| ----------------------- | ----------------- |
| Increase font size      | `Ctrl+=`           |
| Decrease font size      | `Ctrl+-`           |
| Reset font size         | `Ctrl+0`           |

## Misc

| Action                    | Keys              |
| ------------------------- | ----------------- |
| Command palette           | `Ctrl+Shift+P`    |
| Toggle fullscreen         | `F11`             |
| Open new window / tab     | `Ctrl+Shift+N` / `Ctrl+Shift+T` |
| Reload config             | `Ctrl+Shift+R`    |
| Show debug overlay        | `Ctrl+Shift+L`    |

> Tip: reload your config on the fly with `Ctrl+Shift+R` after editing
> `wezterm.lua` — no restart needed.

## Configuration highlights (see `wezterm.lua`)

- `default_prog` — program spawned in a new pane/tab/window (here: PowerShell).
- `color_scheme` — built-in scheme, e.g. `tokyonight_night`.
- `font` / `font_size` — font family string and size.
- `colors` — overlay table that only overrides the keys you set.