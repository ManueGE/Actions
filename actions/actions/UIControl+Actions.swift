//
//  UIControl+Actions.swift
//  actions
//
//  Created by Manu on 1/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit

private protocol ControlAction: Action {
    var controlEvent: UIControlEvents { get }
}

private class ControlVoidAction: VoidAction, ControlAction {
    fileprivate let controlEvent: UIControlEvents
    init(event: UIControlEvents, action: @escaping () -> Void) {
        controlEvent = event
        super.init(action: action)
    }
}

private class ControlParametizedAction<T: UIControl>: ParametizedAction<T>, ControlAction {
    fileprivate let controlEvent: UIControlEvents
    init(event: UIControlEvents, action: @escaping (T) -> Void) {
        controlEvent = event
        super.init(action: action)
    }
}

// Action to manage the two parameters selector allowed in controls
private class EventAction<T: UIControl>: ControlAction {
    
    fileprivate let controlEvent: UIControlEvents
    @objc let key = ProcessInfo.processInfo.globallyUniqueString
    @objc let selector: Selector = #selector(perform)
    
    let action: (T, UIEvent?) -> Void
    
    @objc func perform(parameter: AnyObject, event: UIEvent?) {
        action(parameter as! T, event)
    }
    
    init(event: UIControlEvents, action: @escaping (T, UIEvent?) -> Void) {
        self.action = action
        controlEvent = event
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
    @discardableResult
    public func add<T: UIControl>(event: UIControlEvents, action: @escaping (T, UIEvent?) -> Void) -> Action {
        let action = EventAction(event: event, action: action)
        add(event: event, action: action)
        return action
    }
    
    /**
     Adds the given action as response to the given control event.
     - parameter event: The event that the control must receive to trigger the closure
     - parameter action: The closure that will be called when the gesture is detected
     - returns: The added action
     */
    @discardableResult
    public func add<T: UIControl>(event: UIControlEvents, action: @escaping (T) -> Void) -> Action {
        let action = ControlParametizedAction(event: event, action: action)
        add(event: event, action: action)
        return action
    }
    
    /**
     Adds the given action as response to the given control event.
     - parameter event: The event that the control must receive to trigger the closure
     - parameter action: The closure that will be called when the gesture is detected
     - returns: The added action
     */
    @discardableResult
    public func add(event: UIControlEvents, action: @escaping () -> Void) -> Action {
        let action = ControlVoidAction(event: event, action: action)
        add(event: event, action: action)
        return action
    }
    
    
    // MARK: Multiple events
    
    /**
     Adds the given action as response to the given control events.
     - parameter events: The events that the control must receive to trigger the closure
     - parameter action: The closure that will be called when the gesture is detected
     - returns: The added actions
     */
    @discardableResult
    public func add<T: UIControl>(events: [UIControlEvents], action: @escaping (T, UIEvent?) -> Void) -> [Action] {
        return events.map { add(event: $0, action: action) }
    }
    
    /**
     Adds the given action as response to the given control events.
     - parameter events: The events that the control must receive to trigger the closure
     - parameter action: The closure that will be called when the gesture is detected
     - returns: The added actions
     */
    @discardableResult
    public func addAction<T: UIControl>(events: [UIControlEvents], action: @escaping (T) -> Void) -> [Action] {
        return events.map { add(event: $0, action: action) }
    }
    
    /**
     Adds the given action as response to the given control events.
     - parameter events: The events that the control must receive to trigger the closure
     - parameter action: The closure that will be called when the gesture is detected
     - returns: The added actions
     */
    @discardableResult
    public func addAction(events: [UIControlEvents], action: @escaping () -> Void) -> [Action] {
        return events.map { add(event: $0, action: action) }
    }
    
    // MARK: Private
    private func add(event: UIControlEvents, action: Action) {
        retainAction(action, self)
        addTarget(action,
                  action: action.selector,
                  for: event)
    }
    
    // MARK: Remove
    /**
     Disable the given action to be launched as response of the received event
     - parameter action: The action to disable
     - parameter events: The control events that you want to remove for the specified target object
     */
    public func remove(action: Action, forControlEvents events: UIControlEvents) {
        removeTarget(action, action: action.selector, for: events)
        releaseAction(action, self)
    }
}
