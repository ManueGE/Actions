//
//  UIGestureRecognizerViewController.swift
//  actions
//
//  Created by Manuel García-Estañ on 1/11/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit
import Actions

class UIGestureRecognizerViewController: BaseViewController {

    @IBOutlet weak var dragView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Actions - UIGestureRecognizer"
        
        let panRecognizer = UIPanGestureRecognizer { (pan: UIPanGestureRecognizer) in
            
            guard let view = pan.view else { return }
            
            let translation = pan.translation(in: view)
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
            
            pan.setTranslation(CGPoint(), in: view)
        }
        
        dragView.gestureRecognizers = [panRecognizer]
    }
}
