//
//  Data.swift
//  actions
//
//  Created by Manuel García-Estañ on 1/11/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import Foundation

struct AppData {
    
    let title: String
    let storybordIdentifier: String
    
    static let all: [AppData] = {
        return [
            AppData(title: "UIView", storybordIdentifier: "UIViewViewController"),
            AppData(title: "UIControl", storybordIdentifier: "UIControlViewController"),
            AppData(title: "UIGestureRecognizer", storybordIdentifier: "UIGestureRecognizerViewController"),
            AppData(title: "UIBarbuttonItem", storybordIdentifier: "UIBarbuttonItemViewController"),
            AppData(title: "Timer", storybordIdentifier: "TimerViewController"),
            AppData(title: "NotificationCenter", storybordIdentifier: "NotificationCenterViewController"),
        ]
    }()
}
