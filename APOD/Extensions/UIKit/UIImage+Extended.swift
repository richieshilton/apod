//
//  UIImage+Extended.swift
//  APOD
//
//  Created by Richie Shilton on 5/7/20.
//

import UIKit

extension UIImage: NSDiscardableContent {
    
    public func beginContentAccess() -> Bool {
        return true
    }
    
    public func endContentAccess() { }
    
    public func discardContentIfPossible() { }
    
    public func isContentDiscarded() -> Bool {
        return false
    }
}
