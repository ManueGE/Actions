//
//  UIControl+Throttle.swift
//  actions
//
//  Created by Manuel García-Estañ on 11/10/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit
import ObjectiveC

private typealias ThrottleAndAction = (throttle: ThrottleType, action: Action)

private var throttlesKey: UInt8 = 0

/// Extension which provides a set of methods to Throttle actions triggered by control events.
extension UIControl {
    
    
    /// Add an action for the given control evetn. 
    /// The action is not performed immediately, instead it is scheduled to be executed after the given time interval. 
    /// If the control event is triggered again before the time interval expires, the previous call is canceled.
    /// It prevents the action of being triggered more than once in the given time interval.
    ///
    /// - parameter event:    The event which triggers the action
    /// - parameter interval: The time interval to wait before performing the action
    /// - parameter handler:  The action which will be executed when the time itnerval expires.
    public func throttle<T: UIControl>(_ event: UIControl.Event, interval: TimeInterval, handler: @escaping (T, UIEvent?) -> Void) {
        
        let throttle = Throttle(interval: interval) { (sender, event) in
            handler(sender, event)
        }
        
        let action = add(event: event) { (control: T, event: UIEvent?) in
            throttle.schedule(with: (control, event))
        }
        
        add(throttle: throttle, action: action, for: event)
    }
    
    /// Add an action for the given control evetn.
    /// The action is not performed immediately, instead it is scheduled to be executed after the given time interval.
    /// If the control event is triggered again before the time interval expires, the previous call is canceled.
    /// It prevents the action of being triggered more than once in the given time interval.
    ///
    /// - parameter event:    The event which triggers the action
    /// - parameter interval: The time interval to wait before performing the action
    /// - parameter handler:  The action which will be executed when the time itnerval expires.
    public func throttle<T: UIControl>(_ event: UIControl.Event, interval: TimeInterval, handler: @escaping (T) -> Void) {
        
        let throttle = Throttle(interval: interval, action: handler)
        let action = add(event: event) { (control: T) in
            throttle.schedule(with: control)
        }
        
        add(throttle: throttle, action: action, for: event)
    }
    
    /// Add an action for the given control evetn.
    /// The action is not performed immediately, instead it is scheduled to be executed after the given time interval.
    /// If the control event is triggered again before the time interval expires, the previous call is canceled.
    /// It prevents the action of being triggered more than once in the given time interval.
    ///
    /// - parameter event:    The event which triggers the action
    /// - parameter interval: The time interval to wait before performing the action
    /// - parameter handler:  The action which will be executed when the time itnerval expires.
    public func throttle(_ event: UIControl.Event, interval: TimeInterval, handler: @escaping () -> Void) {
        let throttle = Throttle(interval: interval, action: handler)
        let action = add(event: event) { 
            throttle.schedule(with: ())
        }
        
        add(throttle: throttle, action: action, for: event)
    }
    
    /// Remove the current Throttle (if any) for the given control event
    ///
    /// - parameter event: The event whose Throttle will be removed
    public func removeThrottle(for event: UIControl.Event) {
        if let currentThrottle = self.throttles[event.rawValue] {
            currentThrottle.throttle.cancel()
            remove(currentThrottle.action, for: event)
        }
    }
    
    private func add<T>(throttle: Throttle<T>, action: Action, for event: UIControl.Event) {
        removeThrottle(for: event)
        self.throttles[event.rawValue] = (throttle, action)
    }

    // MARK - Throttles
    private var throttles: [UInt: ThrottleAndAction] {
        get {
            var throttles: [UInt: ThrottleAndAction]
            
            if let storedThrottles = objc_getAssociatedObject(self, &throttlesKey) as? [UInt: ThrottleAndAction] {
                throttles = storedThrottles
            }
            else {
                throttles = [:]
                self.throttles = throttles
            }
            
            return throttles
        }
        set(newValue) {
            objc_setAssociatedObject(self, &throttlesKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
}
