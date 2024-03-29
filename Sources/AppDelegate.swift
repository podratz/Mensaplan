//
//  AppDelegate.swift
//  MensaplanDesktop
//
//  Created by Nick Podratz on 10.06.17.
//  Copyright © 2017 Nick Podratz. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system().statusItem(withLength: -2)
    let popover = NSPopover()
    var eventMonitor: EventMonitor?

    func applicationDidFinishLaunching(_ notification: Notification) {
        setupPopover()
    }

    
    // MARK: - Popover
    
    @objc func togglePopover(sender: AnyObject?) {
        popover.isShown ?
            closePopover(sender: sender) :
            showPopover(sender: sender)
    }
    
    private func setupPopover() {
        if let button = statusItem.button {
            button.image = NSImage(named: "StatusBarButtonImage")
            button.action = #selector(togglePopover)
        }
        
        popover.contentViewController = NSStoryboard.init(name: "Main", bundle: nil).instantiateController(withIdentifier: "PageViewController") as! PageViewController
        
        // Hides VC on press outside of view
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [unowned self] event in
            if self.popover.isShown {
                self.closePopover(sender: event)
            }
        }
    }

    private func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            eventMonitor?.isEnabled = true
        }
    }
    
    private func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
        eventMonitor?.isEnabled = false
    }
    
    
}

