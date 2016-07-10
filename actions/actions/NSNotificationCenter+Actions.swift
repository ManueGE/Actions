//
//  NSNotificationCenter+Actions.swift
//  actions
//
//  Created by Manu on 6/7/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import Foundation

/// Observe notifications with closures instead of a pair of observer/selector
extension NSNotificationCenter {
    
    // MARK: Add observers
    /**
     Adds an entry to the receiver’s dispatch table with a closure and optional criteria: notification name and sender.
     The observation lives until it is manually stopped, so be sure to invoke `stopObserving(_)` when the observation is not longer needed
     - parameter name: The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer.
     If you pass nil, the notification center doesn’t use a notification’s name to decide whether to deliver it to the observer.
     - parameter object: The object whose notifications the observer wants to receive; that is, only notifications sent by this sender are delivered to the observer. Default is `nil`.
     - parameter action: The closure which will be called when a notification with the criteria is sent
     - returns: The action that has been added to the receiver. You can catch this value to stop observing it by calling `stopObserving(_)`.
     */
    public func observe<T: NSNotification>(name: String?, object: AnyObject? = nil, action: (T) -> Void) -> Action {
        let action = ParametizedAction(action: action)
        addObserver(action, selector: action.selector, name: name, object: object)
        retainAction(action, self)
        return action
    }
    
    
    /**
     Adds an entry to the receiver’s dispatch table with a closure and optional criteria: notification name and sender.
     The observation lives until it is manually stopped,, so be sure to invoke `stopObserving(_)` when the observation is not longer needed
     - parameter to: The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer.
     If you pass nil, the notification center doesn’t use a notification’s name to decide whether to deliver it to the observer.
     - parameter object: The object whose notifications the observer wants to receive; that is, only notifications sent by this sender are delivered to the observer. Default is `nil`.
     - parameter action: The closure which will be called when a notification with the criteria is sent
     - returns: The action that has been added to the receiver. You can catch this value to stop observing it by calling `stopObserving(_)`.
     */
    public func observe(name: String?, object: AnyObject? = nil, action: Void -> Void) -> Action {
        let action = VoidAction(action: action)
        addObserver(action, selector: action.selector, name: name, object: object)
        retainAction(action, self)
        return action
    }
    
    /**
     Adds an entry to the receiver’s dispatch table with a closure and optional criteria: notification name and sender.
     The observation lives while the `observer` is not deallocated. In case you need stop the observation before the òbserver` is deallocated, you can do it by invoking `stopObserving(_)`.
     - note: Due to internal implementation, the defaul method `removeObserver` not take any effect on obervations registered using this method.
     - parameter to: The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer.
     If you pass nil, the notification center doesn’t use a notification’s name to decide whether to deliver it to the observer.
     - parameter object: The object whose notifications the observer wants to receive; that is, only notifications sent by this sender are delivered to the observer. Default is `nil`.
     - parameter action: The closure which will be called when a notification with the criteria is sent
     - returns: The action that has been added to the receiver. You can catch this value to stop observing it by calling `stopObserving(_)`.
     */
    public func add(observer observer: NSObject, name: String?, object: AnyObject? = nil, action: Void -> Void) -> Action {
        let action = VoidAction(action: action)
        addObserver(action, selector: action.selector, name: name, object: object)
        retainAction(action, observer)
        return action
    }
    
    /**
     Adds an entry to the receiver’s dispatch table with a closure and optional criteria: notification name and sender.
     The observation lives while the `observer` is not deallocated. In case you need stop the observation before the òbserver` is deallocated, you can do it by invoking `stopObserving(_)`.
     - note: Due to internal implementation, the defaul method `removeObserver` not take any effect on obervations registered using this method.
     - parameter to: The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer.
     If you pass nil, the notification center doesn’t use a notification’s name to decide whether to deliver it to the observer.
     - parameter object: The object whose notifications the observer wants to receive; that is, only notifications sent by this sender are delivered to the observer. Default is `nil`.
     - parameter action: The closure which will be called when a notification with the criteria is sent
     - returns: The action that has been added to the receiver. You can catch this value to stop observing it by calling `stopObserving(_)`.
     */
    public func add<T: NSNotification>(observer observer: NSObject, name: String?, object: AnyObject? = nil, action: T -> Void) -> Action {
        let action = ParametizedAction(action: action)
        addObserver(action, selector: action.selector, name: name, object: object)
        retainAction(action, observer)
        return action
    }
    
    // MARK: Remove observers
    /**
     Stop observing the given action.
     - parameter action: The action which won't be observed anymore
     */
    public func stopObserving(action: Action) {
        NSNotificationCenter.defaultCenter().removeObserver(action)
        releaseAction(action, self)
    }
    
    // MARK: Deprecated methods
    /**
     Adds an entry to the receiver’s dispatch table with a closure and optional criteria: notification name and sender.
     The observation lives until it is manually stopped, so be sure to invoke `stopObserving(_)` when the observation is not longer needed
    - note: This method has been deprecated. Please se `observe(_:object:action)` instead
     - parameter to: The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer.
     If you pass nil, the notification center doesn’t use a notification’s name to decide whether to deliver it to the observer.
     - parameter object: The object whose notifications the observer wants to receive; that is, only notifications sent by this sender are delivered to the observer. Default is `nil`.
     - parameter action: The closure which will be called when a notification with the criteria is sent
     - returns: The action that has been added to the receiver. You can catch this value to stop observing it by calling `stopObserving(_)`.
     */
    @available(*, deprecated, message="Please se `observe(_:object:action)` instead")
    public func addObserver<T: NSNotification>(to name: String?, object: AnyObject? = nil, action: (T) -> Void) -> Action {
        return observe(name, object: object, action: action)
    }
    
    /**
     Adds an entry to the receiver’s dispatch table with a closure and optional criteria: notification name and sender.
     The observation lives until it is manually stopped, so be sure to invoke `stopObserving(_)` when the observation is not longer needed
     - note: This method has been deprecated. Please se `observe(_:object:action)` instead
     - parameter to: The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer.
     If you pass nil, the notification center doesn’t use a notification’s name to decide whether to deliver it to the observer.
     - parameter object: The object whose notifications the observer wants to receive; that is, only notifications sent by this sender are delivered to the observer. Default is `nil`.
     - parameter action: The closure which will be called when a notification with the criteria is sent
     - returns: The action that has been added to the receiver. You can catch this value to stop observing it by calling `stopObserving(_)`.
     */
    @available(*, deprecated, message="Please se `observe(_:object:action)` instead")
    public func addObserver(to name: String?, object: AnyObject? = nil, action: Void -> Void) -> Action {
        return observe(name, object: object, action: action)
    }
    
}