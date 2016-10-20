//
//  Throttle.swift
//  actions
//
//  Created by Manuel García-Estañ on 11/10/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import Foundation

/// Just an internal protocol to encapsulate all the Throttles
internal protocol ThrottleType {
    func scheduleWith(value: Any)
    func cancel()
    func fireWith(value: Any)
}


/// Object that allows scehduele actions to be called after a specific time interval, and prevent it of being called more than once in that interval.
/// If the action is scheduled again before the time interval expires, it cancels the previous call (if any) preventing the action to be called twice.
/// It contains a generic parameter `Argument` that indicates the type of parameter of the action.
public final class Throttle<Argument> {
    
    /// The type of the action.
    public typealias ThrottleAction = (Argument) -> Void
    
    /// The time interval that the Throttle will wait before call the actions
    private let interval: TimeInterval
    
    /// The action which will be called after the time interval
    private let action: ThrottleAction
    
    private var timer: Timer?
    
    
    /// Creates a new instance with the given time interval and action
    ///
    /// - parameter interval: The time interval
    /// - parameter action:   The action
    ///
    /// - returns: The new Throttle
    public init(interval: TimeInterval, action: @escaping ThrottleAction) {
        self.interval = interval
        self.action = action
    }
    
    
    /// Schedule a new call of the action. 
    /// If there is a pending action, it will be cancelled.
    ///
    /// - parameter value: The argument that will be sent as argument to the action closure
    public func schedule(with value: Argument) {
        cancel()
        timer = Timer.scheduledTimer(timeInterval: interval,
                                     target: self,
                                     selector: #selector(Throttle.onTimer),
                                     userInfo: value,
                                     repeats: false)
    }
    
    /// Cancel the pending action, if any.
    public func cancel() {
        timer?.invalidate()
        timer = nil
    }
    
    
    /// Force the execution of the action, without waiting for the interval.
    /// If there is a pending action, it will be cancelled.
    ///
    /// - parameter value: The argument that will be sent as argument to the action closure
    public func fire(with value: Argument) {
        action(value)
    }
    
    @objc private func onTimer(_ timer: Timer) {
        fire(with: timer.userInfo as! Argument)
    }
}

extension Throttle: ThrottleType {
    func scheduleWith(value: Any) {
        guard let value = value as? Argument else {
            return
        }
        
        schedule(with: value)
    }
    
    func fireWith(value: Any) {
        guard let value = value as? Argument else {
            return
        }
        
        fire(with: value)
    }
}
