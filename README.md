# Taskbar Visualizer Widget

**A Windows 11 Rainmeter skin** that docks a real-time audio spectrum visualizer and media info widget directly onto your taskbar — no bloat, just vibes.

![Windows 11](https://img.shields.io/badge/Windows%2011-only-0078D4?logo=windows&logoColor=white)
![Rainmeter](https://img.shields.io/badge/Rainmeter-4.5%2B-22B14C?logo=rainmeter&logoColor=white)
![Author](https://img.shields.io/badge/by-Quisermate-blueviolet)

![preview](preview.gif)

---

## What it does

Two skins in one folder:

| Skin | File | Size | Best for |
|------|------|------|----------|
| **Full Widget** | `FluentTaskbarWidget.ini` | ~310 px wide | Media info + visualizer |
| **Compact Visualizer** | `CompactVisualizer.ini` | 210 px wide | Visualizer-only pill |

Both sit inside the Windows 11 taskbar and react to whatever audio is playing on your PC — music, YouTube, games, anything.

**Features at a glance:**
- 16-band FFT audio spectrum with Lua-smoothed physics (fast attack, natural decay)
- Animated GIF avatar with rounded clip mask
- Scrolling track title & artist pulled from browser tabs (YouTube, Spotify Web…) via WebNowPlaying, or from desktop apps via Windows SMTC
- Scroll the mouse wheel over the widget to adjust system volume
- Left-click → Play / Pause the current track
- Native Windows 11 **Acrylic blur** background via the FrostedGlass plugin
- Right-click context menu to change size, theme, and docking side — no config file editing needed

---

## Requirements

- **Windows 10 or 11** (Windows 11 recommended for best Acrylic blur)
- [Rainmeter 4.5+](https://www.rainmeter.net/) — free, open-source
- The following Rainmeter plugins (place `.dll` files in `%APPDATA%\Rainmeter\Plugins\`):
  - [AudioLevel](https://docs.rainmeter.net/manual/plugins/audiolevel/) — built into Rainmeter
  - [FrostedGlass](https://github.com/Hazedd/FrostedGlass/releases) — acrylic blur
  - [WebNowPlaying](https://github.com/tjhrulz/WebNowPlaying-Rainmeter/releases) — browser media info
  - [Win7AudioPlugin](https://forum.rainmeter.net/viewtopic.php?t=13997) — volume scrolling

> [!NOTE]
> AudioLevel ships with Rainmeter. You only need to manually install the other three.

---

## Installation

### Step 1 — Download

Clone this repo or download the ZIP and extract it:

```
git clone https://github.com/quisermate-code/TaskbarVisualizerWidget.git
```

### Step 2 — Add to Rainmeter Skins folder

**Option A — Symlink (best for keeping the folder where it is):**

Open PowerShell and run:
```powershell
New-Item -ItemType Junction -Path "$env:USERPROFILE\Documents\Rainmeter\Skins\TaskbarVisualizerWidget" -Target "PATH\TO\taskbar-visualizer-widget"
```
Replace `PATH\TO\taskbar-visualizer-widget` with wherever you cloned/extracted the folder.

**Option B — Copy the folder:**

Copy the entire folder into:
```
%USERPROFILE%\Documents\Rainmeter\Skins\TaskbarVisualizerWidget\
```

### Step 3 — Load the skin

1. Open **Rainmeter** (right-click the tray icon → Manage)
2. Click **Refresh All**
3. Expand **TaskbarVisualizerWidget** in the skin list
4. Click **Load** next to `FluentTaskbarWidget.ini` (or `CompactVisualizer.ini`)

### Step 4 — Position it on the taskbar

1. Right-click the skin → **Settings** → enable **Stay Topmost** and **Keep on screen**
2. Drag the widget onto your taskbar
3. Once happy with the position, right-click → **Settings** → disable **Draggable**

> [!TIP]
> The widget is sized to sit inside the standard 48 px Windows 11 taskbar. If your taskbar is a different size, right-click the skin and use the **Size** options to scale it up or down.

---

## Browser media (WebNowPlaying)

To show track title and artist from YouTube, Spotify Web, SoundCloud, etc.:

1. Install the browser extension:
   - [Chrome / Edge](https://chrome.google.com/webstore/detail/webnowtplaying-companion/jfakgfcdgpghbbefmdfjkbdlibjgnbli)
   - [Firefox](https://addons.mozilla.org/en-US/firefox/addon/web-now-playing/)
2. Make sure `UseWebNowPlaying=1` is set in `@Resources\Variables.inc` (it is by default)
3. Play something in your browser — the widget picks it up automatically

---

## Customization

Right-click the widget → **Widget Size Controller** or **Visualizer Color** for the most common tweaks.

For deeper changes, open `@Resources\Variables.inc` in any text editor:

| Variable | Default | What it controls |
|----------|---------|-----------------|
| `Scale` | `1.3` | Overall widget scale (1.0 – 1.6) |
| `BarColor` | `255,255,255,240` | Visualizer bar colour (RGBA) |
| `FFTAttack` | `18` | How fast bars rise (ms) |
| `FFTDecay` | `130` | How fast bars fall (ms) |
| `Sensitivity` | `40` | Audio sensitivity — raise if bars seem low |
| `TransparentMode` | `1` | `1` = fully transparent bg, `0` = acrylic blur |
| `TaskbarPosition` | `Right` | Docking side: `Right` or `Left` |
| `GifTotalFrames` | `50` | Number of frames in your GIF avatar |

### Swapping the GIF avatar

Drop your own GIF frames (exported as `frame_0.png`, `frame_1.png`, …) into:
```
@Resources\Images\Gif\
```
Update `GifTotalFrames` in `Variables.inc` to match the frame count, then refresh the skin.

---

## Project layout

```
TaskbarVisualizerWidget/
├── @Resources/
│   ├── Images/
│   │   └── Gif/          ← GIF frames (frame_0.png … frame_N.png)
│   ├── Scripts/
│   │   ├── Visualizer.lua    ← Lua physics smoothing for bars
│   │   └── FetchMedia.ps1    ← PowerShell SMTC media fetcher
│   ├── Variables.inc         ← All tunable settings live here
│   └── MediaInfo.inc         ← Auto-updated by FetchMedia.ps1
├── FluentTaskbarWidget.ini   ← Full widget skin
├── CompactVisualizer.ini     ← Compact visualizer-only skin
└── preview.gif
```

---

## Credits

- [FluentFlyout](https://github.com/unchihugo/FluentFlyout) by *unchihugo* — design inspiration
- [Rainmeter](https://www.rainmeter.net/) — the engine that makes all of this possible
- [WebNowPlaying](https://github.com/tjhrulz/WebNowPlaying-Rainmeter) — browser media bridge
- [FrostedGlass](https://github.com/Hazedd/FrostedGlass) — native acrylic blur plugin

---

*Made by [Quisermate](https://github.com/Quisermate) — a solo hobby project.*

