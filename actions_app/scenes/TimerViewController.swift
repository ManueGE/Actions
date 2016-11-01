//
//  TimerViewController.swift
//  actions
//
//  Created by Manuel García-Estañ on 1/11/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit
import Actions

class TimerViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Actions - Timer"
    }
    
    @IBAction func didPressTimer(_ sender: AnyObject) {
        Timer.scheduledTimer(timeInterval: 5) { [weak self] (timer: Timer) in
            self?.showAlert(message: "Timer \(timer) did expire")
        }
    }
    
}
