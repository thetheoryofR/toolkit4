# GPTK4 Launcher

A small macOS launcher that automates setting up **Apple Game Porting Toolkit 4**
(DirectX 12 → **Metal 4** translation) with **CrossOver**, so you don't have to
do the manual file-copying and config editing every time.

It automates the workflow from the setup video:

1. Duplicates `CrossOver.app` → `CrossOver GPTK4.app` (your stock CrossOver is never touched).
2. Mounts the GPTK4 *Evaluation Environment* disk image and swaps its
   `redistributable/lib` folders into the duplicate's
   `Contents/SharedSupport/CrossOver/lib64/apple_gptk` (originals are kept as `*.backup`).
3. Copies the NVIDIA DLSS shim into the Steam bottle's `windows/system32`
   (`nvngx_on_metal.dll` is renamed to `nvngx.dll`).
4. Adds the config keys to the bottle's `cxbottle.conf`:
   - `"D3DM_MTL4" = "1"` — enables the Metal 4 backend
   - `"MTL_HUD_ENABLED" = "1"` — Metal performance HUD (shows `D3D12 (Metal 4)` in-game)
   - `"D3DM_MAX_FPS"` — optional frame-rate cap
5. Launches Steam through the patched CrossOver.

## Prerequisites (one-time, manual)

These can't be automated because they need your logins/licenses:

| Step | What to do | Download |
|---|---|---|
| macOS 27.0 "Golden Gate" beta | Required for the Metal 4 translation layer | [Apple beta downloads](https://developer.apple.com/download/) · [Full installers (Mr. Macintosh)](https://mrmacintosh.com/) |
| Apple Developer account | Register your Apple ID for free — needed to download GPTK4 | [developer.apple.com/register](https://developer.apple.com/register/) |
| GPTK 4 Evaluation Environment | Log in with your registered Apple ID, search "Game Porting Toolkit", and download the **Evaluation Environment** DMG into `~/Downloads` | [developer.apple.com/download/all](https://developer.apple.com/download/all/?q=game%20porting%20toolkit) |
| CrossOver (26.1+) | Install to `/Applications` and activate your license or the free 14-day trial | [codeweavers.com/crossover/download](https://www.codeweavers.com/crossover/download) |
| Steam bottle | In CrossOver: **Install → Steam**, click through the installers, log in to Steam once, then quit | — |
| Bottle toggles | In the Steam bottle's settings, turn **D3DMetal** and **DLSS** ON | — |

The GUI also has a **📥 Get the downloads** menu option that opens these pages for you.

## Easiest way: the GUI

No Terminal needed:

1. Double-click **`Create App.command`** once. This builds **GPTK4 Launcher.app**
   in your Applications folder.
2. Open **GPTK4 Launcher** from Launchpad or Spotlight. You'll get a simple menu:
   - **🎮 Launch Steam (Metal 4)** — starts Steam through the patched CrossOver
   - **🛠 Set up GPTK4** — does the whole setup with normal Mac dialogs
     (it finds the downloaded disk image automatically, or lets you pick it)
   - **✅ Check my setup** — tells you what's missing, in plain language
   - **↩️ Restore original CrossOver** — undoes the setup

If something goes wrong, the error dialog has a **View Log** button
(the log lives at `~/Library/Logs/gptk4-launcher.log`).

> First time macOS may block the `.command` file: right-click it → **Open** → **Open**.

You can also skip building the app and just double-click
**`GPTK4 Launcher.command`** — it opens the same menu.

## Command-line usage

```sh
./gptk4 check                  # verify everything is in place
./gptk4 setup                  # patch everything (finds the DMG in ~/Downloads)
./gptk4 setup /path/to/Evaluation_Environment.dmg   # or pass the DMG explicitly
./gptk4 launch                 # start Steam through CrossOver GPTK4
./gptk4 restore                # put the original CrossOver libraries back
```

## Configuration

Edit the variables at the top of `gptk4`, or use environment variables:

- `GPTK4_BOTTLE` — bottle name if yours isn't called `Steam`
- `GPTK4_MAX_FPS` — e.g. `GPTK4_MAX_FPS=60 ./gptk4 setup` to cap frame rate (saves battery)

## Notes

- Only **DirectX 12** games go through the Metal 4 layer; the HUD in the top-right
  of a game will read `D3D12 (Metal 4)` when it's active.
- Re-running `setup` is safe: backups are only made once, and config keys are
  updated rather than duplicated.
- `restore` undoes the library swap inside `CrossOver GPTK4.app` if a CrossOver
  update or a new GPTK build misbehaves.
