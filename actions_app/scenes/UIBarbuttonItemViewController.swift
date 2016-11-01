//
//  UIBarbuttonItemViewController.swift
//  actions
//
//  Created by Manuel García-Estañ on 1/11/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit
import Actions

class UIBarbuttonItemViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Actions - UIBarButtonItem"
        
        let systemItem = UIBarButtonItem(barButtonSystemItem: .action) { [unowned self] in
            self.showAlert(message: "Did press \"Action\" item")
        }
        
        let titleItem = UIBarButtonItem(title: "Item") { [unowned self] (item: UIBarButtonItem) in
            self.showAlert(message: "Did press \(item)")
        }
        
        navigationItem.rightBarButtonItems = [systemItem, titleItem]
        
    }
}
