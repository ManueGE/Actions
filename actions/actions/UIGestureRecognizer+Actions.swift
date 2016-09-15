//
//  UIGestureRecognizer+Actions.swift
//  actions
//
//  Created by Manu on 1/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit


/// Extension that provides methods to add actions to gesture recognizer
extension UIGestureRecognizer {
    
    /**
     Initializes a new item with the given action
     - parameter action: The action to be called when the button is tapped
     - returns: Newly initialized item with the specified action.
     */
    public convenience init<T: UIGestureRecognizer>(action: @escaping (T) -> Void) {
        let action = ParametizedAction(action: action)
        self.init(target: action, action: action.selector)
        retainAction(action, self)
    }
    
    /**
     Initializes a new item with the given action
     - parameter action: The action to be called when the button is tapped
     - returns: Newly initialized item with the specified action.
     */
    public convenience init(action: @escaping () -> Void) {
        let action = VoidAction(action: action)
        self.init(target: action, action: action.selector)
        retainAction(action, self)
    }
}
