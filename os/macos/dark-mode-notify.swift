#!/usr/bin/env swift

// # dark-mode-notify
//
// This small Swift program will run a command whenever the dark mode status
// changes on macOS. You can use it to change your vim color config
// automatically for example.
//
// ## Usage
//
// You can run it directly by doing `
// $ ./dark-mode-notify.swift <program>
//
// Alternatively you can compile it by doing
// $ swiftc dark-mode-notify.swift -o /usr/local/bin/dark-mode-notify
//
// The program will be run immediately when the command starts, and every time
// the OS goes from dark mode to light mode or back. The environment variable
// `DARKMODE` will be set to either `1` or `0`.
//
// ## Background agent
//
// To keep this program running in the background, compile the binary to
// somewhere and create the following file at
// `~/Library/LaunchAgents/ke.bou.dark-mode-notify.plist`. Don't forget to
// replace the arguments and the path to the logs (which comes in handy for
// debugging)
//
// ```xml
// <?xml version="1.0" encoding="UTF-8"?>
// <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
// "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
// <plist version="1.0">
// <dict>
//     <key>Label</key>
//     <string>ke.bou.dark-mode-notify</string>
//     <key>KeepAlive</key>
//     <true/>
//     <key>StandardErrorPath</key>
//     <string>----Path to a location----/dark-mode-notify-stderr.log</string>
//     <key>StandardOutPath</key>
//     <string>----Path to a location----/dark-mode-notify-stdout.log</string>
//     <key>ProgramArguments</key>
//     <array>
//        <string>/usr/local/bin/dark-mode-notify</string>
//        <string>--- Path to your script ---</string>
//     </array>
// </dict>
// </plist>
// ```
//
// Then `launchctl load -w ~/Library/LaunchAgents/ke.bou.dark-mode-notify.plist`
// will keep it running on boot.
//
// # Credit
//
// Root: https://arslan.io/2021/02/15/automatic-dark-mode-for-terminal-applications
// Most credit goes to https://github.com/mnewt/dotemacs/blob/master/bin/dark-mode-notifier.swift
// Source: https://github.com/bouk/dark-mode-notify

import Cocoa

@discardableResult
func shell(_ args: [String]) -> Int32 {
    let task = Process()
    let isDark = UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark"
    var env = ProcessInfo.processInfo.environment
    env["DARKMODE"] = isDark ? "1" : "0"
    task.environment = env
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.standardError = FileHandle.standardError
    task.standardOutput = FileHandle.standardOutput
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

let args = Array(CommandLine.arguments.suffix(from: 1))
shell(args)

DistributedNotificationCenter.default.addObserver(
    forName: Notification.Name("AppleInterfaceThemeChangedNotification"),
    object: nil,
    queue: nil) { (notification) in
        shell(args)
}

NSApplication.shared.run()
