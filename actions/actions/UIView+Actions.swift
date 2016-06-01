//
//  UIView+Actions.swift
//  actions
//
//  Created by Manu on 1/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit

public enum Gesture {
    case tap(Int)
    case swipe(UISwipeGestureRecognizerDirection)
    
    case multiTap(taps: Int, fingers: Int)
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

extension UIView: Actionable {
    
    public func addAction<T: UIView>(gesture: Gesture, action: T -> Void) -> UIGestureRecognizer {
        let action = ActionWithParameter(parameter: (self as! T), action: action)
        return addAction(gesture, action: action)
    }
    
    public func addAction(gesture: Gesture, action: Void -> Void) -> UIGestureRecognizer {
        let action = VoidAction(action: action)
        return addAction(gesture, action: action)
    }
    
    public func addAction<T: UIView>(action: T -> Void) -> UIGestureRecognizer {
        let action = ActionWithParameter(parameter: (self as! T), action: action)
        return addAction(.tap(1), action: action)
    }
    
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
