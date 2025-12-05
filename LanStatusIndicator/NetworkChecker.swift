//
//  NetworkChecker.swift
//  LanStatusIndicator
//
//  Created by Kenneth Wooten  on 04.12.2025.
//

import Foundation

class NetworkChecker {
    private var interfaceName: String?

    init() {
        interfaceName = findEthernetInterface()
        if interfaceName == nil {
            print("⚠️ No USB-LAN interface found")
        } else {
            print("Detected interface: \(interfaceName!)")
        }
    }

    func isConnected() -> Bool {
        guard let iface = interfaceName else {
            return false
        }
        let task = Process()
        task.launchPath = "/sbin/ifconfig"
        task.arguments = [iface]

        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = Pipe()
        task.launch()
        task.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(decoding: data, as: UTF8.self)

        return output.contains("status: active")
    }
}
func findEthernetInterface() -> String? {
    let task = Process()
    task.launchPath = "/usr/sbin/networksetup"
    task.arguments = ["-listallhardwareports"]

    let pipe = Pipe()
    task.standardOutput = pipe
    task.standardError = Pipe()
    task.launch()
    task.waitUntilExit()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    guard let output = String(data: data, encoding: .utf8) else {
        return nil
    }

    // Split blocks by blank lines
    let blocks = output.components(separatedBy: "\n\n")
    for block in blocks {
        // Look for a hardware port matching USB/Ethernet/LAN
        if block.lowercased().contains("usb") &&
           (block.lowercased().contains("lan") || block.lowercased().contains("ethernet")) {
            // Find the Device line
            for line in block.components(separatedBy: "\n") {
                let trimmed = line.trimmingCharacters(in: .whitespaces)
                if trimmed.lowercased().hasPrefix("device:") {
                    let parts = trimmed.components(separatedBy: ":")
                    if parts.count >= 2 {
                        let device = parts[1].trimmingCharacters(in: .whitespaces)
                        return device  // e.g. "en11"
                    }
                }
            }
        }
    }

    return nil
}
