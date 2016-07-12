//
//  ViewController.swift
//  Swift-Rain
//
//  Created by Kiran Kunigiri on 7/22/15.
//  Copyright (c) 2015 Kiran Kunigiri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var waterController: WaterController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        waterController = WaterController(view: self.view)
        waterController.start()
    }

    @IBAction func startButtonTapped(sender: UIButton) {
        if waterController.isAnimating {
            waterController.stop()
            sender.setTitle("Start", forState: .Normal)
        } else {
            waterController.start()
            sender.setTitle("Stop", forState: .Normal)
        }
    }

}

