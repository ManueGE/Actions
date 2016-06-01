//
//  Action.swift
//  actions
//
//  Created by Manu on 1/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit
import ObjectiveC

// MARK: Action
@objc protocol Action {
    @objc func perform()
}

extension Action {
    var selector: Selector { return #selector(perform) }
}

class ActionWithParameter<T: NSObject>: Action {
    
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
    
    var action: (Void -> Void)!
    
    init(action: Void -> Void) {
        self.action = action
    }
    
    @objc func perform() {
        action()
    }
}

// MARK: Targetable
/*!
 Targetable is a protocol used to store `Action` instances. Its only purpose is avoid them to be deallocated.
 */
protocol Actionable: class {
    var actions: [Action]? { get set }
}

private var actionsKey: UInt8 = 0
extension Actionable {
    var actions: [Action]? {
        get {
            var targets = objc_getAssociatedObject(self, &actionsKey) as? [Action]
            
            if targets == nil {
                targets = []
                objc_setAssociatedObject(self, &actionsKey, targets, .OBJC_ASSOCIATION_RETAIN)
            }
            
            return targets
        }
        set(newValue) {
            objc_setAssociatedObject(self, &actionsKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func retainAction(action: Action) {
        actions!.append(action)
    }
}
