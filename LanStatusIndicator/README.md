# LAN Status Indicator for macOS

A clean and lightweight macOS menu bar utility that shows **real-time Ethernet connection status** — perfect for USB-C → RJ45 adapters.

---

## 🚀 Features

- 🟢 **Green dot** — Ethernet connected
- 🔴 **Red dot** — Ethernet disconnected
- 🍏 **Native macOS menu bar UI**
- 🔍 Automatically detects USB-LAN interfaces (enX)
- 🌙 Supports Light & Dark Mode
- ⚙️ Runs silently in the background
- 🔌 Optional: auto-launch at login
- 🖥 Universal build: **Apple Silicon + Intel**

---

## 🛠 How It Works

LAN Status Indicator uses the macOS `networksetup` and `ifconfig` tools to:

1. Detect the correct USB-LAN hardware port
2. Monitor Ethernet carrier status
3. Draw a custom 16×16 macOS-style icon
4. Overlay a connection dot (red/green)

The app **does not use any private APIs**.

---

## 🧩 Install from Source (Build in Xcode)

If you prefer to build the app yourself instead of downloading a pre-built `.app`, follow these steps:

### 1. Clone the repository

```bash
git clone https://github.com/kennwooten/LanIndicator-macos.git

cd LAN-Status

2. Open the project in Xcode
open LanStatusIndicator.xcodeproj

3. Select the correct build target

In the Xcode toolbar:

Scheme → LAN Status Indicator → Any Mac (Apple Silicon, Intel)

Do NOT use "My Mac (Debug)" for release builds.

4. Build & Run
⌘ + R



After installation, you can **optionally add the app to macOS background processes** so it launches silently at startup:

1. Open **System Settings → General → Login Items**
2. Under **Allow in Background**, enable **LAN Status Indicator**
3. (Optional) Under **Open at Login**, toggle it ON if you want the app to auto-start

This ensures the menu bar indicator runs automatically after each reboot.


MIT License — free to use, modify, and distribute.
