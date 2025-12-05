//
//  StatusBarController.swift
//  LanStatusIndicator
//
//  Created by Kenneth Wooten on 04.12.2025.
//

import Cocoa

class StatusBarController {

    private let statusItem: NSStatusItem
    private let checker = NetworkChecker()
    private var timer: Timer?

    init() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusItem.button {
            button.toolTip = "LAN Status"
        }

        setupMenu()
        updateUI()
        startTimer()
    }

    // MARK: - Menu

    private func setupMenu() {
        let menu = NSMenu()

        let statusMenuItem = NSMenuItem(title: "Checking…", action: nil, keyEquivalent: "")
        statusMenuItem.tag = 100
        menu.addItem(statusMenuItem)

        menu.addItem(.separator())

        let quitItem = NSMenuItem(title: "Quit LAN Status", action: #selector(quitApp), keyEquivalent: "q")
        quitItem.target = self
        menu.addItem(quitItem)

        statusItem.menu = menu
    }

    // MARK: - Timer

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            self?.updateUI()
        }
    }

    // MARK: - UI Update

    private func updateUI() {
        let connected = checker.isConnected()
        let iconName = "ethernetIcon"

        guard let baseGlyph = NSImage(named: iconName) else {
            print("ERROR: ethernetIcon not found in assets!")
            return
        }

        // Ideal macOS menu bar icon size
        let iconSize = NSSize(width: 16, height: 16)

        // Canvas where we draw glyph + dot
        let finalImage = NSImage(size: iconSize)
        finalImage.lockFocus()

        // Draw the base glyph stretched into our 16x16 area
        baseGlyph.size = iconSize
        baseGlyph.draw(
            in: NSRect(origin: .zero, size: iconSize),
            from: .zero,
            operation: .sourceOver,
            fraction: 1.0
        )

        // Dot size and placement (BOTTOM CENTER)
        let dotDiameter: CGFloat = 4.0

        // CENTER (horizontal + vertical)
        let dotX: CGFloat = (iconSize.width - dotDiameter) / 2
        let dotY: CGFloat = (iconSize.height - dotDiameter) / 2

        let dotRect = NSRect(x: dotX, y: dotY, width: dotDiameter, height: dotDiameter)

        let dotColor = connected ? NSColor.systemGreen : NSColor.systemRed
        dotColor.setFill()
        NSBezierPath(ovalIn: dotRect).fill()

        finalImage.unlockFocus()
        finalImage.isTemplate = false   // full-color image, do NOT template-tint


        // Apply to menu bar
        if let button = statusItem.button {
            button.image = finalImage
            button.image?.size = iconSize
            button.image?.isTemplate = false
        }

        // Update menu text
        if let menu = statusItem.menu,
           let statusItem = menu.items.first(where: { $0.tag == 100 }) {

            statusItem.title = connected
                ? "Ethernet: Connected"
                : "Ethernet: Disconnected"
        }
    }

    // MARK: - Quit

    @objc private func quitApp() {
        NSApp.terminate(nil)
    }
}
