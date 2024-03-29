//
//  VerticallyCenteredTextFieldCell.swift
//  MensaplanDesktop
//
//  Created by Nick Podratz on 10.07.17.
//  Copyright © 2017 Nick Podratz. All rights reserved.
//

import Cocoa

class VerticallyCenteredTextFieldCell: NSTextFieldCell {
    
    // MARK: Custom Drawing
    
    override func titleRect(forBounds rect: NSRect) -> NSRect {
        var titleRect = super.titleRect(forBounds: rect)
        
        let minimumHeight = self.cellSize(forBounds: rect).height
        titleRect.origin.y += (titleRect.height - minimumHeight) / 2
        titleRect.size.height = minimumHeight
        
        return titleRect
    }
    
    override func drawInterior(withFrame cellFrame: NSRect, in controlView: NSView) {
        super.drawInterior(withFrame: titleRect(forBounds: cellFrame), in: controlView)
    }
    
    override func select(withFrame rect: NSRect, in controlView: NSView, editor textObj: NSText, delegate: Any?, start selStart: Int, length selLength: Int) {
        super.select(withFrame: titleRect(forBounds: rect), in: controlView, editor: textObj, delegate: delegate, start: selStart, length: selLength);
    }
    
    
}

