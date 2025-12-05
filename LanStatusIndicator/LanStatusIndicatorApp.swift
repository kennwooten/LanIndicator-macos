//
//  LanStatusIndicatorApp.swift
//  LanStatusIndicator
//
//  Created by Константин  on 05.12.2025.
//

import SwiftUI

@main
struct LanStatusIndicatorApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        // NO WINDOWS — hidden app
        Settings {
            EmptyView()
        }
    }
}
