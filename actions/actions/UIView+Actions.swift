//
//  UIView+Actions.swift
//  actions
//
//  Created by Manu on 1/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit

/**
 Action where the parameter can be assigned manually
 */
private class CustomParametizedAction<T: NSObject>: Action {
    
    @objc let key = ProcessInfo.processInfo.globallyUniqueString
    @objc let selector: Selector = #selector(perform)
    
    let action: ((T) -> Void)
    weak var parameter: T?
    
    init(parameter: T?, action: @escaping (T) -> Void) {
        self.action = action
        self.parameter = parameter
    }
    
    @objc func perform() {
        guard let parameter = parameter else { return }
        action(parameter)
    }
}

/**
 The gestures that can be used to trigger actions in `UIView`
 */
public enum Gesture {
    
    /// A tap gesture with a single finger and the given number of touches
    case tap(Int)
    
    /// A swipe gesture with a single finger and the given direction
    case swipe(UISwipeGestureRecognizer.Direction)
    
    /// A tap gesture with the given number of touches and fingers
    case multiTap(taps: Int, fingers: Int)
    
    /// A swipe gesture with the given direction and number of fingers
    case multiSwipe(direction: UISwipeGestureRecognizer.Direction, fingers: Int)
    
    fileprivate func recognizer(action: Action) -> UIGestureRecognizer {
        
        switch self {
        case let .tap(taps):
            let recognizer = UITapGestureRecognizer(target: action, action: action.selector)
            recognizer.numberOfTapsRequired = taps
            return recognizer
            
        case let .swipe(direction):
            let recognizer = UISwipeGestureRecognizer(target: action, action: action.selector)
            recognizer.direction = direction
            return recognizer
            
        case let .multiTap(taps, fingers):
            let recognizer = UITapGestureRecognizer(target: action, action: action.selector)
            recognizer.numberOfTapsRequired = taps
            recognizer.numberOfTouchesRequired = fingers
            return recognizer
            
        case let .multiSwipe(direction, fingers):
            let recognizer = UISwipeGestureRecognizer(target: action, action: action.selector)
            recognizer.direction = direction
            recognizer.numberOfTouchesRequired = fingers
            return recognizer
        }
    }
}

/// Extension that provides methods to add actions to views
extension UIView {
    
    /**
     Adds the given action as response to the gesture.
     - parameter gesture: The gesture that the view must receive to trigger the closure
     - parameter action: The closure that will be called when the gesture is detected
     - returns: The gesture recognizer that has been added
     */
    @discardableResult
    public func add<T: UIView>(gesture: Gesture, action: @escaping (T) -> Void) -> UIGestureRecognizer {
        let action = CustomParametizedAction(parameter: (self as! T), action: action)
        return add(gesture: gesture, action: action)
    }
    
    /**
     Adds the given action as response to the gesture.
     - parameter gesture: The gesture that the view must receive to trigger the closure
     - parameter action: The closure that will be called when the gesture is detected
     - returns: The gesture recognizer that has been added
     */
    @discardableResult
    public func add(gesture: Gesture, action: @escaping () -> Void) -> UIGestureRecognizer {
        let action = VoidAction(action: action)
        return add(gesture: gesture, action: action)
    }
    
    /**
     Adds the given action as response to a single tap gesture.
     - parameter gesture: The gesture that the view must receive to trigger the closure
     - parameter action: The closure that will be called when the gesture is detected
     - returns: The gesture recognizer that has been added
     */
    @discardableResult
    public func addTap<T: UIView>(action: @escaping (T) -> Void) -> UIGestureRecognizer {
        let action = CustomParametizedAction(parameter: (self as! T), action: action)
        return add(gesture: .tap(1), action: action)
    }
    
    /**
     Adds the given action as response to a single tap gesture.
     - parameter gesture: The gesture that the view must receive to trigger the closure
     - parameter action: The closure that will be called when the gesture is detected
     - returns: The gesture recognizer that has been added
     */
    @discardableResult
    public func addAction(action: @escaping () -> Void) -> UIGestureRecognizer {
        let action = VoidAction(action: action)
        return add(gesture: .tap(1), action: action)
    }
    
    @discardableResult
    private func add(gesture: Gesture, action: Action) -> UIGestureRecognizer{
        retainAction(action, self)
        let gesture = gesture.recognizer(action: action)
        isUserInteractionEnabled = true
        addGestureRecognizer(gesture)
        return gesture
    }
}
