//
//  NotificationCenter+Actions.swift
//  actions
//
//  Created by Manu on 6/7/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import Foundation

private protocol NotificationCenterAction: Action {
    var notificationName: NSNotification.Name? { get }
    var notificationObject: AnyObject? { get }
}

private class NotificationCenterVoidAction: VoidAction, NotificationCenterAction {
    fileprivate let notificationName: NSNotification.Name?
    fileprivate let notificationObject: AnyObject?
    fileprivate init(name: NSNotification.Name?, object: AnyObject?, action: @escaping () -> Void) {
        self.notificationName = name
        self.notificationObject = object
        super.init(action: action)
    }
}

private class NotificationCenterParametizedAction: ParametizedAction<NSNotification>, NotificationCenterAction {
    fileprivate let notificationName: NSNotification.Name?
    fileprivate let notificationObject: AnyObject?
    fileprivate init(name: NSNotification.Name?, object: AnyObject?, action: @escaping (NSNotification) -> Void) {
        self.notificationName = name
        self.notificationObject = object;
        super.init(action: action)
    }
}

/// Observe notifications with closures instead of a pair of observer/selector
extension NotificationCenter {
    
    // MARK: Add observers
    
    /**
     Adds an entry to the receiver’s dispatch table with a closure and optional criteria: notification name and sender.
     The observation lives until it is manually stopped,, so be sure to invoke `stopObserving(_)` when the observation is not longer needed
     - parameter name: The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer.
     If you pass nil, the notification center doesn’t use a notification’s name to decide whether to deliver it to the observer.
     - parameter object: The object whose notifications the observer wants to receive; that is, only notifications sent by this sender are delivered to the observer. Default is `nil`.
     - parameter action: The closure which will be called when a notification with the criteria is sent
     - returns: The action that has been added to the receiver. You can catch this value to stop observing it by calling `stopObserving(_)`.
     */
    @discardableResult
    public func observe(_ name: NSNotification.Name?, object: AnyObject? = nil, action: @escaping () -> Void) -> Action {
        let action = NotificationCenterVoidAction(name: name, object: object, action: action)
        addObserver(action, selector: action.selector, name: name, object: object)
        retainAction(action, self)
        return action
    }
    
    /**
     Adds an entry to the receiver’s dispatch table with a closure and optional criteria: notification name and sender.
     The observation lives until it is manually stopped, so be sure to invoke `stopObserving(_)` when the observation is not longer needed
     - parameter name: The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer.
     If you pass nil, the notification center doesn’t use a notification’s name to decide whether to deliver it to the observer.
     - parameter object: The object whose notifications the observer wants to receive; that is, only notifications sent by this sender are delivered to the observer. Default is `nil`.
     - parameter action: The closure which will be called when a notification with the criteria is sent
     - returns: The action that has been added to the receiver. You can catch this value to stop observing it by calling `stopObserving(_)`.
     */
    @discardableResult
    @nonobjc
    public func observe(_ name: NSNotification.Name?, object: AnyObject? = nil, action: @escaping (NSNotification) -> Void) -> Action {
        let action = NotificationCenterParametizedAction(name: name, object: object, action: action)
        addObserver(action, selector: action.selector, name: name, object: object)
        retainAction(action, self)
        return action
    }
    
    /**
     Adds an entry to the receiver’s dispatch table with a closure and optional criteria: notification name and sender.
     The observation lives while the `observer` is not deallocated. In case you need stop the observation before the òbserver` is deallocated, you can do it by invoking `stopObserving(_)`.
     - note: Due to internal implementation, the defaul method `removeObserver` not take any effect on obervations registered using this method.
     - parameter observer: Object registering as an observer. This value must not be nil.
     If you pass nil, the notification center doesn’t use a notification’s name to decide whether to deliver it to the observer.
     - parameter name: The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer.
     If you pass nil, the notification center doesn’t use a notification’s name to decide whether to deliver it to the observer.
     
     - parameter object: The object whose notifications the observer wants to receive; that is, only notifications sent by this sender are delivered to the observer. Default is `nil`.
     - parameter action: The closure which will be called when a notification with the criteria is sent
     - returns: The action that has been added to the receiver. You can catch this value to stop observing it by calling `stopObserving(_)`.
     */
    @discardableResult
    public func add(observer: NSObject, name: NSNotification.Name?, object: AnyObject? = nil, action: @escaping () -> Void) -> Action {
        let action = NotificationCenterVoidAction(name: name, object: object, action: action)
        addObserver(action, selector: action.selector, name: name, object: object)
        retainAction(action, observer)
        return action
    }
    
    /**
     Adds an entry to the receiver’s dispatch table with a closure and optional criteria: notification name and sender.
     The observation lives while the `observer` is not deallocated. In case you need stop the observation before the òbserver` is deallocated, you can do it by invoking `stopObserving(_)`.
     - note: Due to internal implementation, the defaul method `removeObserver` not take any effect on obervations registered using this method.
     - parameter observer: Object registering as an observer. This value must not be nil.
     If you pass nil, the notification center doesn’t use a notification’s name to decide whether to deliver it to the observer.
     - parameter name: The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer.
     If you pass nil, the notification center doesn’t use a notification’s name to decide whether to deliver it to the observer.
     
     - parameter object: The object whose notifications the observer wants to receive; that is, only notifications sent by this sender are delivered to the observer. Default is `nil`.
     - parameter action: The closure which will be called when a notification with the criteria is sent
     - returns: The action that has been added to the receiver. You can catch this value to stop observing it by calling `stopObserving(_)`.
     */
    @discardableResult
    @nonobjc
    public func add(observer: NSObject, name: NSNotification.Name?, object: AnyObject? = nil, action: @escaping (NSNotification) -> Void) -> Action {
        let action = NotificationCenterParametizedAction(name: name, object: object, action: action)
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
        NotificationCenter.default.removeObserver(action)
        releaseAction(action, self)
    }
    
    /**
     Removes all the entries specifying a given observer from the receiver’s dispatch table.
     Be sure to invoke this method (or stopObserver(_:name:object:)) before observer or any object specified in add(observer:name:action:) is deallocated.
     You should not use this method to remove all observers from an object that is going to be long-lived, because your code may not be the only code adding observers that involve the object.
     - parameter observer: Object unregistered as observer.
     - parameter name: The name of the notification for which to unregister the observer; if nil, notifications with any name will be stopped.
     - parameter object: The object whose notifications the observer wants to stop; if nil, notifications from any object will be stopped.
     */
    public func stopObserver(_ observer: NSObject, name: NSNotification.Name? = nil, object: AnyObject? = nil) {
        for (_, value) in observer.actions {
            
            guard let action = value as? NotificationCenterAction else {
                continue
            }
            
            var matches: Bool
            
            switch (name, object) {
            case (nil, nil):
                matches = true
            case let (.some(name), nil):
                matches = (name == action.notificationName)
            case let (nil, .some(object)):
                matches = (object === object)
            case let (.some(name), .some(object)):
                matches = (object === object) && (name == action.notificationName)
            }
            
            if matches {
                stopObserving(action: action)
            }
        }
    }
}
