//
//  UIView+Actions.swift
//  actions
//
//  Created by Manu on 1/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit

/**
 The gestures that can be used to trigger actions in `UIView`
 */
public enum Gesture {
    
    /// A tap gesture with a single finger and the given number of touches
    case tap(Int)
    
    /// A swipe gesture with a single finger and the given direction
    case swipe(UISwipeGestureRecognizerDirection)
    
    /// A tap gesture with the given number of touches and fingers
    case multiTap(taps: Int, fingers: Int)
    
    /// A swipe gesture with the given direction and number of fingers
    case multiSwipe(direction: UISwipeGestureRecognizerDirection, fingers: Int)
    
    private func recognizer(action: Action) -> UIGestureRecognizer {
        
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
extension UIView: Actionable {
    
    /**
     Adds the given action as response to the gesture.
     - parameter gesture: The gesture that the view must receive to trigger the closure
     - parameter action: The closure that will be called when the gesture is detected
     - returns: The gesture recognizer that has been added
     */
    public func addAction<T: UIView>(gesture: Gesture, action: T -> Void) -> UIGestureRecognizer {
        let action = ParametizedAction(parameter: (self as! T), action: action)
        return addAction(gesture, action: action)
    }
    
    /**
     Adds the given action as response to the gesture.
     - parameter gesture: The gesture that the view must receive to trigger the closure
     - parameter action: The closure that will be called when the gesture is detected
     - returns: The gesture recognizer that has been added
     */
    public func addAction(gesture: Gesture, action: Void -> Void) -> UIGestureRecognizer {
        let action = VoidAction(action: action)
        return addAction(gesture, action: action)
    }
    
    /**
     Adds the given action as response to a single tap gesture.
     - parameter gesture: The gesture that the view must receive to trigger the closure
     - parameter action: The closure that will be called when the gesture is detected
     - returns: The gesture recognizer that has been added
     */
    public func addAction<T: UIView>(action: T -> Void) -> UIGestureRecognizer {
        let action = ParametizedAction(parameter: (self as! T), action: action)
        return addAction(.tap(1), action: action)
    }
    
    /**
     Adds the given action as response to a single tap gesture.
     - parameter gesture: The gesture that the view must receive to trigger the closure
     - parameter action: The closure that will be called when the gesture is detected
     - returns: The gesture recognizer that has been added
     */
    public func addAction(action: Void -> Void) -> UIGestureRecognizer {
        let action = VoidAction(action: action)
        return addAction(.tap(1), action: action)
    }
    
    private func addAction(gesture: Gesture, action: Action) -> UIGestureRecognizer{
        retainAction(action)
        let gesture = gesture.recognizer(action)
        userInteractionEnabled = true
        addGestureRecognizer(gesture)
        return gesture
    }
}
