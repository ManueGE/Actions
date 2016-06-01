//
//  ViewController.swift
//  actions
//
//  Created by Manu on 1/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redView.addAction(emptyAction)
        blueView.addAction(parameterAction)
        redView.addAction(.swipe(.Left), action: emptyAction)
        redView.addAction(.multiTap(taps: 5, fingers: 2), action: parameterAction)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Left", action: barButtonAction)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, action: emptyAction)
        
        let recognizer = UIPinchGestureRecognizer { (recognizer) in
            print(recognizer)
        }
        blueView.addGestureRecognizer(recognizer)
        
        textField.addAction(.EditingChanged) { (textField: UITextField) in
            print("Text did change: \(textField.text)")
        }
        
        segmentedControl.addAction(.ValueChanged) { (segmented: UISegmentedControl) in
            print("Segmented did change \(segmented.selectedSegmentIndex)")
        }
        
        button.addAction(.TouchUpInside) {
            print("button tapped")
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
    }
}

