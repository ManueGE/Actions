//
//  UIControl+Actions.swift
//  actions
//
//  Created by Manu on 1/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit

extension UIControl {
    
    func addAction<T: UIControl>(event: UIControlEvents, action: T -> Void) -> Action {
        let action = ActionWithParameter(parameter: (self as! T), action: action)
        addAction(event, action: action)
        return action
    }
    
    func addAction(event: UIControlEvents, action: Void -> Void) -> Action {
        let action = VoidAction(action: action)
        addAction(event, action: action)
        return action
    }
    
    private func addAction(event: UIControlEvents, action: Action) {
        retainAction(action)
        addTarget(action,
                  action: action.selector,
                  forControlEvents: event)
    }
    
    func removeAction(action: Action, forControlEvents events: UIControlEvents) {
        removeTarget(action, action: action.selector, forControlEvents: events)
    }
}
