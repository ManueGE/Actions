//
//  ViewController.swift
//  actions
//
//  Created by Manu on 1/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit

extension NSNotification.Name {
    static var notificationName: NSNotification.Name {
        return NSNotification.Name("NotificationName")
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var action: Action?
    var notificationAction: Action!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redView.addAction(action: emptyAction)
        blueView.addTap(action: parameterAction)
        redView.add(gesture: .swipe(.left), action: parameterAction)
        redView.add(gesture: .multiTap(taps: 5, fingers: 2), action: parameterAction)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Left", action: barButtonAction)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, action: emptyAction)
        
        let recognizer = UIPinchGestureRecognizer { (recognizer) in
            print(recognizer)
        }
        blueView.addGestureRecognizer(recognizer)
        
        textField.add(event: .editingChanged) { (textField: UITextField) in
            print("Text did change: \(textField.text)")
        }
        
        textField.throttle(.editingChanged, interval: 2) { (textField: UITextField) in
            print("Text changed to: \(textField.text)")
        }
        
        action = segmentedControl.add(event: .valueChanged, action: didPressSegment)
        
        button.add(event: .touchUpInside) {
            print("button tapped")
        }
        
        button.add(event: .touchUpInside, action: eventAction)
        
        label.add(gesture: .swipe(.left), action: parameterAction)
        
        Timer.scheduledTimer(timeInterval: 5) {
            print("timer fired")
        }
        
        let center = NotificationCenter.default
        notificationAction = center.observe(.notificationName) {
            print("Notification received")
        }
        
        center.observe(.notificationName, object: self) { (notification: NSNotification) in
            print("Notification \(notification) received")
        }
    }
    
    func emptyAction() {
        print("Empty")
    }
    
    func parameterAction(view: UIView) {
        print("pram: \(view)")
    }
    
    func barButtonAction(item: UIBarButtonItem) {
        print("item: \(item)")
        NotificationCenter.default.post(name: .notificationName,
                                        object: self,
                                        userInfo: ["test": "test"])
        
        textField.throttle(.editingChanged, interval: 1) { (textField: UITextField) in
            print("And now the text changed again to: \(textField.text)")
        }
    }
    
    func didPressSegment(segmented: UISegmentedControl) {
        print("Segmented did change \(segmented.selectedSegmentIndex)")
        segmentedControl.remove(action: action!, forControlEvents: .valueChanged)
        NotificationCenter.default.stopObserving(action: notificationAction)
    }
    
    func eventAction(sender: UIButton, event: UIEvent?) {
        print("Sender: \(sender), Event: \(event)")
    }
}

