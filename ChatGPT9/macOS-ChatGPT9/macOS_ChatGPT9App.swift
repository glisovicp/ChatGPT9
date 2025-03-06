//
//  macOS_ChatGPT9App.swift
//  macOS-ChatGPT9
//
//  Created by Petar Glisovic on 10/2/24.
//

import SwiftUI

@main
struct macOS_ChatGPT9App: App {

    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Model())
                .environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {

    private var statusItem: NSStatusItem!
    private var popover: NSPopover!

    func applicationDidFinishLaunching(_ notification: Notification) {

        let contentView = ContentView().environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
            .environmentObject(Model())

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(systemSymbolName: "brain", accessibilityDescription: "Brain")
            statusButton.action = #selector(togglePopover)
        }

        self.popover = NSPopover()
        self.popover.contentSize = NSSize(width: 600, height: 600)
        self.popover.behavior = .transient                                                  // popover closes when user clicks outside
        self.popover.contentViewController = NSHostingController(rootView: contentView)
    }

    @objc func togglePopover() {
        if let button = statusItem.button {
            if popover.isShown {
                self.popover.performClose(nil)
            } else {
                self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }
}
