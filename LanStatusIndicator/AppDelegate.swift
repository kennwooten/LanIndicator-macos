//
//  AppDelegate.swift
//  LanStatusIndicator
//
//  Created by Kenneth Wooten on 04.12.2025.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    var statusBarController: StatusBarController?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create the menu bar icon controller
        statusBarController = StatusBarController()
    }

    func applicationWillTerminate(_ notification: Notification) {
        // nothing to clean up
    }
}
