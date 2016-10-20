//
//  Timer+Actions.swift
//  actions
//
//  Created by Manu on 4/7/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import Foundation

/// Extension that allow create and schedule `Timers` with closures instead of target/selector
extension Timer {
    
    // MARK: Inits with fire date
    
    /**
     Initializes a new Timer object using the specified action.
     The receiver, initialized such that, when added to a run loop, it will fire at date and then, if repeats is true, every ti after that.
     - parameter fireDate: The time at which the timer should first fire.
     - parameter interval: For a repeating timer, this parameter contains the number of seconds between firings of the timer. If ti is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead.
     - parameter userInfo: Custom user info for the timer. The timer maintains a strong reference to this object until it (the timer) is invalidated. This parameter is nil by default.
     - parameter repeats: If true, the timer will repeatedly reschedule itself until invalidated. If false, the timer will be invalidated after it fires. Default is false
     - parameter action: The closure called on the timeout
     - returns: The receiver, initialized such that, when added to a run loop, it will fire at date and then, if repeats is YES, every ti after that.
     */
    public convenience init<T: Timer>(fireAt fireDate: Date, interval: TimeInterval, userInfo: AnyObject? = nil, repeats: Bool = false, action: @escaping (T) -> Void) {
        let action = ParametizedAction(action: action)
        self.init(fireAt: fireDate, interval: 0, target: action, selector: action.selector, userInfo: userInfo, repeats: repeats)
        retainAction(action, self)
    }
    
    /** 
     Initializes a new Timer object using the specified action.
     The receiver, initialized such that, when added to a run loop, it will fire at date and then, if repeats is true, every ti after that.
     - parameter fireAt: The time at which the timer should first fire.
     - parameter interval: For a repeating timer, this parameter contains the number of seconds between firings of the timer. If ti is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead.
     - parameter userInfo: Custom user info for the timer. The timer maintains a strong reference to this object until it (the timer) is invalidated. This parameter is nil by default.
     - parameter repeats: If true, the timer will repeatedly reschedule itself until invalidated. If false, the timer will be invalidated after it fires. Default is false
     - parameter action: The closure called on the timeout
     - returns: The receiver, initialized such that, when added to a run loop, it will fire at date and then, if repeats is YES, every ti after that.
     */
    public convenience init(fireAt fireDate: Date, interval: TimeInterval, userInfo: AnyObject? = nil, repeats: Bool = false, action: @escaping () -> Void) {
        let action = VoidAction(action: action)
        self.init(fireAt: fireDate, interval: 0, target: action, selector: action.selector, userInfo: userInfo, repeats: repeats)
        retainAction(action, self)
    }
    
    // MARK: Inits with time interval
    /**
     Initializes a new Timer object using the specified action.
     The receiver, initialized such that, when added to a run loop, it will fire at date and then, if repeats is true, every ti after that.
     - parameter timeInterval: The number of seconds between firings of the timer. If ti is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead.
     - parameter userInfo: Custom user info for the timer. The timer maintains a strong reference to this object until it (the timer) is invalidated. This parameter is nil by default.
     - parameter repeats: If true, the timer will repeatedly reschedule itself until invalidated. If false, the timer will be invalidated after it fires. Default is false
     - parameter action: The closure called on the timeout
     - returns: A new Timer object, configured according to the specified parameters.
     */
    public convenience init<T: Timer>(timeInterval interval: TimeInterval, userInfo: AnyObject? = nil, repeats: Bool = false, action: @escaping (T) -> Void) {
        let action = ParametizedAction(action: action)
        self.init(timeInterval: interval, target: action, selector: action.selector, userInfo: userInfo, repeats: repeats)
        retainAction(action, self)
    }
    
    /**
     Initializes a new Timer object using the specified action.
     The receiver, initialized such that, when added to a run loop, it will fire at date and then, if repeats is true, every ti after that.
     - parameter timeInterval: The number of seconds between firings of the timer. If ti is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead.
     - parameter userInfo: Custom user info for the timer. The timer maintains a strong reference to this object until it (the timer) is invalidated. This parameter is nil by default.
     - parameter repeats: If true, the timer will repeatedly reschedule itself until invalidated. If false, the timer will be invalidated after it fires. Default is false
     - parameter action: The closure called on the timeout
     - returns: A new Timer object, configured according to the specified parameters.
     */
    public convenience init(timeInterval interval: TimeInterval, userInfo: AnyObject? = nil, repeats: Bool = false, action: @escaping () -> Void) {
        let action = VoidAction(action: action)
        self.init(timeInterval: interval, target: action, selector: action.selector, userInfo: userInfo, repeats: repeats)
        retainAction(action, self)
    }
    
    // MARK: Schedule with interval
    /** 
     Creates and returns a new Timer object and schedules it on the current run loop in the default mode.
     - parameter timeInterval: The number of seconds between firings of the timer. If ti is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead.
     - parameter userInfo: Custom user info for the timer. The timer maintains a strong reference to this object until it (the timer) is invalidated. This parameter is nil by default.
     - parameter repeats: If true, the timer will repeatedly reschedule itself until invalidated. If false, the timer will be invalidated after it fires. Default is false
     - parameter action: The closure called on the timeout
     - returns: A new Timer object, configured according to the specified parameters.
     */
    @discardableResult
    public class func scheduledTimer<T: Timer>(timeInterval: TimeInterval, userInfo: AnyObject? = nil, repeats: Bool = false, action: @escaping (T) -> Void) -> Timer {
        let action = ParametizedAction(action: action)
        
        let timer = self.scheduledTimer(timeInterval: timeInterval,
                                        target: action,
                                        selector: action.selector,
                                        userInfo: userInfo,
                                        repeats: repeats)
        retainAction(action, timer)
        
        return timer
    }
    
    /**
     Creates and returns a new Timer object and schedules it on the current run loop in the default mode.
     - parameter timeInterval: The number of seconds between firings of the timer. If ti is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead.
     - parameter userInfo: Custom user info for the timer. The timer maintains a strong reference to this object until it (the timer) is invalidated. This parameter is nil by default.
     - parameter repeats: If true, the timer will repeatedly reschedule itself until invalidated. If false, the timer will be invalidated after it fires. Default is false
     - parameter action: The closure called on the timeout
     - returns: A new Timer object, configured according to the specified parameters.
     */
    @discardableResult
    public class func scheduledTimer(timeInterval: TimeInterval, userInfo: AnyObject? = nil, repeats: Bool = false, action: @escaping () -> Void) -> Timer {
        let action = VoidAction(action: action)
        
        let timer = self.scheduledTimer(timeInterval: timeInterval,
                                        target: action,
                                        selector: action.selector,
                                        userInfo: userInfo,
                                        repeats: repeats)
        retainAction(action, timer)
        
        return timer
    }
    
}
