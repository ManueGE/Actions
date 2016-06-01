//
//  UIBarButtonItem+Actions.swift
//  actions
//
//  Created by Manu on 1/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit

extension UIBarButtonItem: Actionable {
    
    // MARK: Init with image
    public convenience init<T: UIBarButtonItem>(image: UIImage?, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItemStyle = .Plain, action: T -> Void) {
        let action = ActionWithParameter(parameter: nil, action: action)
        self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: action, action: action.selector)
        action.parameter = self as! T
        retainAction(action)
    }
    
    public convenience init(image: UIImage?, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItemStyle = .Plain, action: Void -> Void) {
        let action = VoidAction(action: action)
        self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: action, action: action.selector)
        retainAction(action)
    }
    
    // MARK: Init with title
    public convenience init<T: UIBarButtonItem>(title: String?, style: UIBarButtonItemStyle = .Plain, action: T -> Void) {
        let action = ActionWithParameter(parameter: nil, action: action)
        self.init(title: title, style: style, target: action, action: action.selector)
        action.parameter = self as! T
        retainAction(action)
    }
    
    public convenience init(title: String?, style: UIBarButtonItemStyle = .Plain, action: Void -> Void) {
        let action = VoidAction(action: action)
        self.init(title: title, style: style, target: action, action: action.selector)
        retainAction(action)
    }
    
    // MARK: Init with system item
    public convenience init<T: UIBarButtonItem>(barButtonSystemItem systemItem: UIBarButtonSystemItem, action: T -> Void) {
        let action = ActionWithParameter(parameter: nil, action: action)
        self.init(barButtonSystemItem: systemItem, target: action, action: action.selector)
        action.parameter = self as! T
        retainAction(action)
    }
    
    public convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, action: Void -> Void) {
        let action = VoidAction(action: action)
        self.init(barButtonSystemItem: systemItem, target: action, action: action.selector)
        retainAction(action)
    }
}
