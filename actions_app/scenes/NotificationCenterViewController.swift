//
//  NotificationCenterViewController.swift
//  actions
//
//  Created by Manuel García-Estañ on 1/11/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit
import Actions

extension NSNotification.Name {
    fileprivate static var notification1: NSNotification.Name { return NSNotification.Name("notification1") }
    fileprivate static var notification2: NSNotification.Name { return NSNotification.Name("notification2") }
}

class NotificationCenterViewController: BaseViewController {

    private var observing = false {
        didSet {
            let title = observing ? "Stop observing Not. 1" : "Start observing Not. 1"
            self.startStopButton.setTitle(title, for: .normal)
            
            if observing {
                NotificationCenter.default.add(observer: self, name: .notification1) { [unowned self] in
                    self.showAlert(message: "Notification 1 caught")
                }
            }
            else {
                NotificationCenter.default.stopObserver(self, name: .notification1)
            }
        }
    }
    
    deinit {
        // post notification 2 to ensure the app does not crash
        Timer.scheduledTimer(timeInterval: 2) {
            NotificationCenter.default.post(name: .notification2, object: nil)
        }
    }
    
    @IBOutlet weak var startStopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Actions - NotificationCenter"
        observing = false
        
        NotificationCenter.default.add(observer: self, name: .notification2) { [unowned self] in
            self.showAlert(message: "Notification 2 caught")
        }
    }

    @IBAction func didPressStartStop(_ sender: AnyObject) {
        observing = !observing
    }
    
    @IBAction func didPressPostNotification1(_ sender: AnyObject) {
        NotificationCenter.default.post(name: .notification1, object: nil)
    }

    @IBAction func didPressPostNotification2(_ sender: AnyObject) {
        NotificationCenter.default.post(name: .notification2, object: nil)
    }
}
