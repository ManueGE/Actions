//
//  UIGestureRecognizer+Actions.swift
//  actions
//
//  Created by Manu on 1/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit

extension UIGestureRecognizer: Actionable {
    convenience init<T: UIGestureRecognizer>(action: T -> Void) {
        let action = ActionWithParameter(parameter: nil, action: action)
        self.init(target: action, action: action.selector)
        action.parameter = self as! T
        retainAction(action)
    }
    
    convenience init(action: Void -> Void) {
        let action = VoidAction(action: action)
        self.init(target: action, action: action.selector)
        retainAction(action)
    }
}