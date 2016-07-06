//
//  NSTimer+Actions.swift
//  actions
//
//  Created by Manu on 4/7/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import Foundation

extension NSTimer: Actionable {
    
    // MARK: Inits with fire date
    
    /**
     Initializes a new NSTimer object using the specified action.
     The receiver, initialized such that, when added to a run loop, it will fire at date and then, if repeats is true, every ti after that.
     - parameter fireDate: The time at which the timer should first fire.
     - parameter interval: For a repeating timer, this parameter contains the number of seconds between firings of the timer. If ti is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead.
     - parameter userInfo: Custom user info for the timer. The timer maintains a strong reference to this object until it (the timer) is invalidated. This parameter is nil by default.
     - parameter repeats: If true, the timer will repeatedly reschedule itself until invalidated. If false, the timer will be invalidated after it fires. Default is false
     - parameter action: The closure called on the timeout
     - returns: The receiver, initialized such that, when added to a run loop, it will fire at date and then, if repeats is YES, every ti after that.
     */
    public convenience init<T: NSTimer>(fireDate: NSDate, interval: NSTimeInterval, userInfo: AnyObject? = nil, repeats: Bool = false, action: T -> Void) {
        let action = ParametizedAction(action: action)
        self.init(fireDate: fireDate, interval: 0, target: action, selector: action.selector, userInfo: userInfo, repeats: repeats)
        retainAction(action)
    }
    
    /** 
     Initializes a new NSTimer object using the specified action.
     The receiver, initialized such that, when added to a run loop, it will fire at date and then, if repeats is true, every ti after that.
     - parameter fireDate: The time at which the timer should first fire.
     - parameter interval: For a repeating timer, this parameter contains the number of seconds between firings of the timer. If ti is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead.
     - parameter userInfo: Custom user info for the timer. The timer maintains a strong reference to this object until it (the timer) is invalidated. This parameter is nil by default.
     - parameter repeats: If true, the timer will repeatedly reschedule itself until invalidated. If false, the timer will be invalidated after it fires. Default is false
     - parameter action: The closure called on the timeout
     - returns: The receiver, initialized such that, when added to a run loop, it will fire at date and then, if repeats is YES, every ti after that.
     */
    public convenience init(fireDate: NSDate, interval: NSTimeInterval, userInfo: AnyObject? = nil, repeats: Bool = false, action: Void -> Void) {
        let action = VoidAction(action: action)
        self.init(fireDate: fireDate, interval: 0, target: action, selector: action.selector, userInfo: userInfo, repeats: repeats)
        retainAction(action)
    }
    
    // MARK: Inits with time interval
    /**
     Initializes a new NSTimer object using the specified action.
     The receiver, initialized such that, when added to a run loop, it will fire at date and then, if repeats is true, every ti after that.
     - parameter timeInterval: The number of seconds between firings of the timer. If ti is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead.
     - parameter userInfo: Custom user info for the timer. The timer maintains a strong reference to this object until it (the timer) is invalidated. This parameter is nil by default.
     - parameter repeats: If true, the timer will repeatedly reschedule itself until invalidated. If false, the timer will be invalidated after it fires. Default is false
     - parameter action: The closure called on the timeout
     - returns: A new NSTimer object, configured according to the specified parameters.
     */
    public convenience init<T: NSTimer>(timeInterval interval: NSTimeInterval, userInfo: AnyObject? = nil, repeats: Bool = false, action: T -> Void) {
        let action = ParametizedAction(action: action)
        self.init(timeInterval: interval, target: action, selector: action.selector, userInfo: userInfo, repeats: repeats)
        retainAction(action)
    }
    
    /**
     Initializes a new NSTimer object using the specified action.
     The receiver, initialized such that, when added to a run loop, it will fire at date and then, if repeats is true, every ti after that.
     - parameter timeInterval: The number of seconds between firings of the timer. If ti is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead.
     - parameter userInfo: Custom user info for the timer. The timer maintains a strong reference to this object until it (the timer) is invalidated. This parameter is nil by default.
     - parameter repeats: If true, the timer will repeatedly reschedule itself until invalidated. If false, the timer will be invalidated after it fires. Default is false
     - parameter action: The closure called on the timeout
     - returns: A new NSTimer object, configured according to the specified parameters.
     */
    public convenience init(timeInterval interval: NSTimeInterval, userInfo: AnyObject? = nil, repeats: Bool = false, action: Void -> Void) {
        let action = VoidAction(action: action)
        self.init(timeInterval: interval, target: action, selector: action.selector, userInfo: userInfo, repeats: repeats)
        retainAction(action)
    }
    
    // MARK: Scheduele with interval
    /** 
     Creates and returns a new NSTimer object and schedules it on the current run loop in the default mode.
     - parameter timeInterval: The number of seconds between firings of the timer. If ti is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead.
     - parameter userInfo: Custom user info for the timer. The timer maintains a strong reference to this object until it (the timer) is invalidated. This parameter is nil by default.
     - parameter repeats: If true, the timer will repeatedly reschedule itself until invalidated. If false, the timer will be invalidated after it fires. Default is false
     - parameter action: The closure called on the timeout
     - returns: A new NSTimer object, configured according to the specified parameters.
     */
    public class func scheduledTimerWithTimeInterval<T: NSTimer>(timeInterval: NSTimeInterval, userInfo: AnyObject? = nil, repeats: Bool = false, action: T -> Void) -> NSTimer {
        let action = ParametizedAction(action: action)
        
        let timer = self.scheduledTimerWithTimeInterval(timeInterval,
                                                        target: action,
                                                        selector: action.selector,
                                                        userInfo: userInfo,
                                                        repeats: repeats)
        timer.retainAction(action)
        
        return timer
    }
 
    /**
     Creates and returns a new NSTimer object and schedules it on the current run loop in the default mode.
     - parameter timeInterval: The number of seconds between firings of the timer. If ti is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead.
     - parameter userInfo: Custom user info for the timer. The timer maintains a strong reference to this object until it (the timer) is invalidated. This parameter is nil by default.
     - parameter repeats: If true, the timer will repeatedly reschedule itself until invalidated. If false, the timer will be invalidated after it fires. Default is false
     - parameter action: The closure called on the timeout
     - returns: A new NSTimer object, configured according to the specified parameters.
     */
    public class func scheduledTimerWithTimeInterval(timeInterval: NSTimeInterval, userInfo: AnyObject? = nil, repeats: Bool = false, action: Void -> Void) -> NSTimer {
        let action = VoidAction(action: action)
        
        let timer = self.scheduledTimerWithTimeInterval(timeInterval,
                                                        target: action,
                                                        selector: action.selector,
                                                        userInfo: userInfo,
                                                        repeats: repeats)
        timer.retainAction(action)
        
        return timer
    }
    
}