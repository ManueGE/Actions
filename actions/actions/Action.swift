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
    @objc func perform()
}

extension Action {
    var selector: Selector { return #selector(perform) }
}

class ActionWithParameter<T: NSObject>: Action {
    
    @objc let key = NSProcessInfo.processInfo().globallyUniqueString
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

class VoidAction: Action {
    
    @objc let key = NSProcessInfo.processInfo().globallyUniqueString
    var action: (Void -> Void)!
    
    init(action: Void -> Void) {
        self.action = action
    }
    
    @objc func perform() {
        action()
    }
}

// MARK: Actionable
/*!
 Targetable is a protocol used to store `Action` instances. Its only purpose is avoid them to be deallocated.
 */
public protocol Actionable: class {
    var actions: [String: Action]? { get }
}

private var actionsKey: UInt8 = 0
public extension Actionable {
    public internal(set) var actions: [String: Action]? {
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
    
    public func retainAction(action: Action) {
        actions![action.key] = action
    }
    
    public func releaseAction(action: Action) {
        actions![action.key] = nil
    }
}
