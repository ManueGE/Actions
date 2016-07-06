//
//  NSNotificationCenter+Actions.swift
//  actions
//
//  Created by Manu on 6/7/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import Foundation

/// Observe notifications with closures instead of a pair of observer/selector
extension NSNotificationCenter: Actionable {
    
    /**
     Adds an entry to the receiver’s dispatch table with a closure and optional criteria: notification name and sender.
     Be sure to invoke removeObserver:name:object: when the observation is not longer needed
     - parameter to: The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer.
     If you pass nil, the notification center doesn’t use a notification’s name to decide whether to deliver it to the observer.
     - parameter object: The object whose notifications the observer wants to receive; that is, only notifications sent by this sender are delivered to the observer. Default is `nil`.
     - parameter action: The closure which will be called when a notification with the criteria is sent
     */
    public func addObserver<T: NSNotification>(to name: String?, object: AnyObject? = nil, action: (T) -> Void) {
        let action = ParametizedAction(action: action)
        NSNotificationCenter.defaultCenter().addObserver(action, selector: action.selector, name: name, object: object)
    }
    
    /**
     Adds an entry to the receiver’s dispatch table with a closure and optional criteria: notification name and sender.
     Be sure to invoke removeObserver:name:object: when the observation is not longer needed
     - parameter to: The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer.
     If you pass nil, the notification center doesn’t use a notification’s name to decide whether to deliver it to the observer.
     - parameter object: The object whose notifications the observer wants to receive; that is, only notifications sent by this sender are delivered to the observer. Default is `nil`.
     - parameter action: The closure which will be called when a notification with the criteria is sent
     */
    public func addObserver(to name: String?, object: AnyObject? = nil, action: Void -> Void) {
        let action = VoidAction(action: action)
        NSNotificationCenter.defaultCenter().addObserver(action, selector: action.selector, name: name, object: object)
    }
    
}