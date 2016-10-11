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
extension UIControl {
    
    public func throttle<T: UIControl>(_ event: UIControlEvents, interval: TimeInterval, handler: @escaping (T, UIEvent?) -> Void) {
        
        let throttle = Throttle(interval: interval) { (sender, event) in
            handler(sender, event)
        }
        
        let action = add(event: event) { (control: T, event: UIEvent?) in
            throttle.scheduele(with: (control, event))
        }
        
        add(throttle: throttle, action: action, for: event)
    }
    
    public func throttle<T: UIControl>(_ event: UIControlEvents, interval: TimeInterval, handler: @escaping (T) -> Void) {
        
        let throttle = Throttle(interval: interval, handler: handler)
        let action = add(event: event) { (control: T) in
            throttle.scheduele(with: control)
        }
        
        add(throttle: throttle, action: action, for: event)
    }
    
    public func throttle(_ event: UIControlEvents, interval: TimeInterval, handler: @escaping () -> Void) {
        let throttle = Throttle(interval: interval, handler: handler)
        let action = add(event: event) { 
            throttle.scheduele(with: ())
        }
        
        add(throttle: throttle, action: action, for: event)
    }
    
    private func add<T>(throttle: Throttle<T>, action: Action, for event: UIControlEvents) {
        
        if let currentThrottle = self.throttles[event.rawValue] {
            currentThrottle.throttle.cancel()
            remove(action: currentThrottle.action, forControlEvents: event)
        }
        
        self.throttles[event.rawValue] = (throttle, action)
    }

    // MARK - throttles
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
