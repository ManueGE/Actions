//
//  UIViewViewController.swift
//  actions
//
//  Created by Manuel García-Estañ on 1/11/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit
import Actions

class UIViewViewController: BaseViewController {
    @IBOutlet weak var tapView: UIView!
    @IBOutlet weak var tapTwiceView: UIView!
    @IBOutlet weak var tapTwoFingersView: UIView!
    @IBOutlet weak var swipeView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Actions - UIView"
        addActions()
    }
    
    private func addActions() {
        tapView.addAction { [unowned self] in
            self.showAlert(message: "View tapped")
        }
        
        tapTwiceView.add(gesture: .tap(2)) { [unowned self] (view: UIView) in
            self.showAlert(message: "View \(view) tapped twice")
        }
        
        tapTwoFingersView.add(gesture: .multiTap(taps: 1, fingers: 2)) { [unowned self] (view: UIView) in
            self.showAlert(message: "View \(view) tapped with two fingers")
        }
        
        swipeView.add(gesture: .swipe(.left)) { [unowned self] in
            self.showAlert(message: "View swipped left")
        }
        
        swipeView.add(gesture: .swipe(.right)) { [unowned self] in
            self.showAlert(message: "View swipped right")
        }
    }
}
