//
//  Action.swift
//  actions
//
//  Created by Manu on 1/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit
import ObjectiveC

/**
 
 */
@objc public protocol Action {
    var key: String { get }
    var selector: Selector { get }
}

class VoidAction: Action {
    
    @objc let key = NSProcessInfo.processInfo().globallyUniqueString
    @objc let selector: Selector = #selector(perform)
    
    var action: (Void -> Void)!
    
    init(action: Void -> Void) {
        self.action = action
    }
    
    @objc func perform() {
        action()
    }
}

class ActionWithParameter<T: NSObject>: Action {
    
    @objc let key = NSProcessInfo.processInfo().globallyUniqueString
    @objc let selector: Selector = #selector(perform)
    
    let action: (T -> Void)!
    internal(set) var parameter: T!
    
    init(parameter: T?, action: T -> Void) {
        self.action = action
        self.parameter = parameter
    }
    
    @objc func perform() {
        action(parameter)
    }
}

// MARK: Actionable
/*!
 Actionable is a protocol used to store `Action` instances. Its only purpose is avoid them to be deallocated.
 */
protocol Actionable: class {
    var actions: [String: Action]? { get }
}

private var actionsKey: UInt8 = 0
extension Actionable {
    internal(set) var actions: [String: Action]? {
        get {
            var targets = objc_getAssociatedObject(self, &actionsKey) as? [String: Action]
            
            if targets == nil {
                targets = [:]
                objc_setAssociatedObject(self, &actionsKey, targets, .OBJC_ASSOCIATION_RETAIN)
            }
            
            return targets
        }
        set(newValue) {
            objc_setAssociatedObject(self, &actionsKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func retainAction(action: Action) {
        actions![action.key] = action
    }
    
    func releaseAction(action: Action) {
        actions![action.key] = nil
    }
}
