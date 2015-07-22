//
//  ViewController.swift
//  Swift-Rain
//
//  Created by Kiran Kunigiri on 7/22/15.
//  Copyright (c) 2015 Kiran Kunigiri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Properties
    var mainWaterController = WaterController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mainWaterController.view = self.view
        mainWaterController.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

