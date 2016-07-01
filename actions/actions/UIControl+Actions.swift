//
//  UIControl+Actions.swift
//  actions
//
//  Created by Manu on 1/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit

// Action to manage the two parameters selector allowed in controls
private class EventAction<T: UIControl>: Action {
    
    @objc let key = NSProcessInfo.processInfo().globallyUniqueString
    @objc let selector: Selector = #selector(perform)
    
    let action: (T, UIEvent?) -> Void
    
    @objc func perform(parameter: AnyObject, event: UIEvent?) {
        action(parameter as! T, event)
    }
    
    init(action: (T, UIEvent?) -> Void) {
        self.action = action
    }
}


/// Extension that provides methods to add actions to controls
public extension UIControl {

    // MARK: Single event
    
    /**
     Adds the given action as response to the given control event.
     - parameter event: The event that the control must receive to trigger the closure
     - parameter action: The closure that will be called when the gesture is detected
     - returns: The added action
     */
    public func addAction<T: UIControl>(event: UIControlEvents, action: (T, UIEvent?) -> Void) -> Action {
        let action = EventAction(action: action)
        addAction(event, action: action)
        return action
    }
    
    /**
     Adds the given action as response to the given control event.
     - parameter event: The event that the control must receive to trigger the closure
     - parameter action: The closure that will be called when the gesture is detected
     - returns: The added action
     */
    public func addAction<T: UIControl>(event: UIControlEvents, action: T -> Void) -> Action {
        let action = ParametizedAction(parameter: (self as! T), action: action)
        addAction(event, action: action)
        return action
    }
    
    /**
     Adds the given action as response to the given control event.
     - parameter event: The event that the control must receive to trigger the closure
     - parameter action: The closure that will be called when the gesture is detected
     - returns: The added action
     */
    public func addAction(event: UIControlEvents, action: Void -> Void) -> Action {
        let action = VoidAction(action: action)
        addAction(event, action: action)
        return action
    }
    
    
    // MARK: Multiple events
    
    /**
     Adds the given action as response to the given control events.
     - parameter events: The events that the control must receive to trigger the closure
     - parameter action: The closure that will be called when the gesture is detected
     - returns: The added actions
     */
    public func addAction<T: UIControl>(events: [UIControlEvents], action: (T, UIEvent?) -> Void) -> [Action] {
        return events.map { addAction($0, action: action) }
    }
    
    /**
     Adds the given action as response to the given control events.
     - parameter events: The events that the control must receive to trigger the closure
     - parameter action: The closure that will be called when the gesture is detected
     - returns: The added actions
     */
    public func addAction<T: UIControl>(events: [UIControlEvents], action: T -> Void) -> [Action] {
        return events.map { addAction($0, action: action) }
    }
    
    /**
     Adds the given action as response to the given control events.
     - parameter events: The events that the control must receive to trigger the closure
     - parameter action: The closure that will be called when the gesture is detected
     - returns: The added actions
     */
    public func addAction(events: [UIControlEvents], action: Void -> Void) -> [Action] {
        return events.map { addAction($0, action: action) }
    }
    
    // MARK: Private
    private func addAction(event: UIControlEvents, action: Action) {
        retainAction(action)
        addTarget(action,
                  action: action.selector,
                  forControlEvents: event)
    }
    
    // MARK: Remove
    /**
     Disable the given action to be launched as response of the received event
     - parameter action: The action to disable
     - parameter events: The control events that you want to remove for the specified target object
     */
    public func removeAction(action: Action, forControlEvents events: UIControlEvents) {
        removeTarget(action, action: action.selector, forControlEvents: events)
        releaseAction(action)
    }
}
