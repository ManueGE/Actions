//
//  UIControlViewController.swift
//  actions
//
//  Created by Manuel García-Estañ on 1/11/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit

class UIControlViewController: BaseViewController {

    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Actions - UIControl"
        
        switchButton.add(event: .valueChanged) { [unowned self] in
            self.showAlert(message: "Switch pressed")
        }
        
        button.add(event: .touchUpInside) { [unowned self] (button: UIButton) in
            self.showAlert(message: "Button \(button) pressed")
        }
        
        textField.throttle(.editingChanged, interval: 1) { [unowned self] (textField: UITextField) in
            self.showAlert(message: "Textfield change text to \"\(textField.text ?? "")\"")
        }
    }
}
