//
//  UIBarButtonItem+Actions.swift
//  actions
//
//  Created by Manu on 1/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit


/// Extension that provides methods to add actions to bar button items
extension UIBarButtonItem {
    
    // MARK: Init with image
    
    /**
     Initializes a new item using the specified image and other properties.
     
     - parameter image: The images displayed on the bar are derived from this image. If this image is too large to fit on the bar, it is scaled to fit. Typically, the size of a toolbar and navigation bar image is 20 x 20 points. The alpha values in the source image are used to create the images—opaque values are ignored.
     - parameter landscapeImagePhone: The style of the item. One of the constants defined in UIBarButtonItemStyle. nil by default
     - parameter style: The style of the item. One of the constants defined in UIBarButtonItemStyle. (.Plain by default)
     - parameter action: The action to be called when the button is tapped
     - returns: Newly initialized item with the specified properties.
     */
    public convenience init<T: UIBarButtonItem>(image: UIImage?, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItem.Style = .plain, action: @escaping (T) -> Void) {
        let action = ParametizedAction(action: action)
        self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: action, action: action.selector)
        retainAction(action, self)
    }
    
    /**
     Initializes a new item using the specified image and other properties.
     
     - parameter image: The images displayed on the bar are derived from this image. If this image is too large to fit on the bar, it is scaled to fit. Typically, the size of a toolbar and navigation bar image is 20 x 20 points. The alpha values in the source image are used to create the images—opaque values are ignored.
     - parameter landscapeImagePhone: The style of the item. One of the constants defined in UIBarButtonItemStyle. nil by default
     - parameter style: The style of the item. One of the constants defined in UIBarButtonItemStyle. (.Plain by default)
     - parameter action: The action to be called when the button is tapped
     - returns: Newly initialized item with the specified properties.
     */
    public convenience init(image: UIImage?, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItem.Style = .plain, action: @escaping () -> Void) {
        let action = VoidAction(action: action)
        self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: action, action: action.selector)
        retainAction(action, self)
    }
    
    // MARK: Init with title
    
    /**
     Initializes a new item using the specified title and other properties.
     
     - parameter title: The item’s title.
     - parameter style: The style of the item. One of the constants defined in UIBarButtonItemStyle. (.Plain by default)
     - parameter action: The action to be called when the button is tapped
     - returns: Newly initialized item with the specified properties.
     */
    public convenience init<T: UIBarButtonItem>(title: String?, style: UIBarButtonItem.Style = .plain, action: @escaping (T) -> Void) {
        let action = ParametizedAction(action: action)
        self.init(title: title, style: style, target: action, action: action.selector)
        retainAction(action, self)
    }
    
    /**
     Initializes a new item using the specified title and other properties.
     
     - parameter title: The item’s title.
     - parameter style: The style of the item. One of the constants defined in UIBarButtonItemStyle. (.Plain by default)
     - parameter action: The action to be called when the button is tapped
     - returns: Newly initialized item with the specified properties.
     */
    public convenience init(title: String?, style: UIBarButtonItem.Style = .plain, action: @escaping () -> Void) {
        let action = VoidAction(action: action)
        self.init(title: title, style: style, target: action, action: action.selector)
        retainAction(action, self)
    }
    
    // MARK: Init with system item
    
    /**
     Initializes a new item containing the specified system item.
     
     - parameter systemItem: The system item to use as the first item on the bar. One of the constants defined in UIBarButtonSystemItem.
     - parameter action: The action to be called when the button is tapped
     - returns: Newly initialized item with the specified properties.
     */
    public convenience init<T: UIBarButtonItem>(barButtonSystemItem systemItem: UIBarButtonItem.SystemItem, action: @escaping (T) -> Void) {
        let action = ParametizedAction(action: action)
        self.init(barButtonSystemItem: systemItem, target: action, action: action.selector)
        retainAction(action, self)
    }
    
    /**
     Initializes a new item containing the specified system item.
     
     - parameter systemItem: The system item to use as the first item on the bar. One of the constants defined in UIBarButtonSystemItem.
     - parameter action: The action to be called when the button is tapped
     - returns: Newly initialized item with the specified properties.
     */
    public convenience init(barButtonSystemItem systemItem: UIBarButtonItem.SystemItem, action: @escaping () -> Void) {
        let action = VoidAction(action: action)
        self.init(barButtonSystemItem: systemItem, target: action, action: action.selector)
        retainAction(action, self)
    }
}
