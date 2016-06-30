//
//  UIControl+Actions.swift
//  actions
//
//  Created by Manu on 1/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit


private class EventAction<T: UIControl>: Action {
    
    @objc let key = NSProcessInfo.processInfo().globallyUniqueString
    @objc let selector: Selector = #selector(perform)
    
    let action: (T, UIEvent) -> Void
    
    @objc func perform(parameter: AnyObject, event: UIEvent) {
        action(parameter as! T, event)
    }
    
    init(action: (T, UIEvent) -> Void) {
        self.action = action
    }
}

public extension UIControl {

    // MARK: Single event
    public func addAction<T: UIControl>(event: UIControlEvents, action: (T, UIEvent) -> Void) -> Action {
        let action = EventAction(action: action)
        addAction(event, action)
        return action
    }
    
    public func addAction<T: UIControl>(event: UIControlEvents, action: T -> Void) -> Action {
        let action = ActionWithParameter(parameter: (self as! T), action: action)
        addAction(event, action)
        return action
    }
    
    public func addAction(event: UIControlEvents, action: Void -> Void) -> Action {
        let action = VoidAction(action: action)
        addAction(event, action)
        return action
    }
    
    private func addAction(event: UIControlEvents, action: Action) {
        retainAction(action)
        addTarget(action,
                  action: action.selector,
                  forControlEvents: event)
    }
    
    // MARK: Multiple events
    public func addAction<T: UIControl>(events: [UIControlEvents], action: (T, UIEvent) -> Void) -> [Action] {
        return events.map { addAction($0, action: action) }
    }
    
    public func addAction<T: UIControl>(events: [UIControlEvents], action: T -> Void) -> [Action] {
        return events.map { addAction($0, action: action) }
    }
    
    public func addAction(events: [UIControlEvents], action: Void -> Void) -> [Action] {
        return events.map { addAction($0, action: action) }
    }
    
    // MARK: Private
    private func addAction(event: UIControlEvents, _ action: Action) {
        retainAction(action)
        addTarget(action,
                  action: action.selector,
                  forControlEvents: event)
    }
    
    // MARK: Remove
    public func removeAction(action: Action, forControlEvents events: UIControlEvents) {
        removeTarget(action, action: action.selector, forControlEvents: events)
        releaseAction(action)
    }
}
