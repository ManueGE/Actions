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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redView.addAction(emptyAction)
        blueView.addAction(parameterAction)
        redView.addAction(.swipe(.Left), action: emptyAction)
        label.addAction(.tap(5), action: parameterAction)
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

