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
 Protocol used to convert Swift closures into ObjC selectors
 */
@objc public protocol Action {
    // The key used to store the `Action`. Must be unique.
    var key: String { get }
    
    // The selector provided by the action
    var selector: Selector { get }
}

// Action that takes zero parameters
class VoidAction: Action {
    
    @objc let key = ProcessInfo.processInfo.globallyUniqueString
    @objc let selector: Selector = #selector(perform)
    
    var action: (() -> Void)!
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    @objc func perform() {
        action()
    }
}

// Action which takes one single parameter
class ParametizedAction<T: Any>: Action {
    
    @objc let key = ProcessInfo.processInfo.globallyUniqueString
    @objc let selector: Selector = #selector(perform)
    
    let action: ((T) -> Void)!
    
    init(action: @escaping (T) -> Void) {
        self.action = action
    }
    
    @objc func perform(parameter: AnyObject) {
        action(parameter as! T)
    }
}


// MARK: Actionable
/*!
 Actionable is a protocol used to store `Action` instances. Its only purpose is avoid them to be deallocated.
 */
protocol Actionable: class {
    var actions: [String: Action]! { get }
}

private var actionsKey: UInt8 = 0
extension Actionable {
    fileprivate(set) var actions: [String: Action]! {
        get {
            var actions = objc_getAssociatedObject(self, &actionsKey) as? [String: Action]
            
            if actions == nil {
                actions = [:]
                self.actions = actions
            }
            
            return actions
        }
        set(newValue) {
            objc_setAssociatedObject(self, &actionsKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

func retainAction(_ action: Action, _ object: NSObject) {
    object.actions[action.key] = action
}

func releaseAction(_ action: Action, _ object: NSObject) {
    object.actions[action.key] = nil
}

extension NSObject: Actionable {}
