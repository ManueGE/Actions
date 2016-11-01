//
//  BaseViewController.swift
//  actions
//
//  Created by Manuel García-Estañ on 1/11/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    deinit {
        print("Deinit \(self)")
    }
    
    func showAlert(message: String) {
        let alertView = UIAlertController(title: "Actions",
                                          message: message,
                                          preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok",
                                          style: .cancel,
                                          handler: nil))
        
        present(alertView, animated: true, completion: nil)
    }
}
