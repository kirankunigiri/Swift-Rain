//
//  WaterController.swift
//  Physics
//
//  Created by Kiran Kunigiri on 7/18/15.
//  Copyright (c) 2015 Kiran Kunigiri. All rights reserved.
//

import Foundation
import UIKit

class WaterController: NSObject {
    
    var view: UIView = UIView()
    var animator = UIDynamicAnimator()
    var drops: [UIView] = []
    
    // Create var for start pos of rain (startX,startY), and distances between drops w/ meaningless values
    var startX = CGFloat(100)
    var startY = CGFloat(175)
    var distanceBetweenEachDrop = CGFloat(18)
    var distanceBetweenSameRow = CGFloat(50)
    
    //create light blue color for rain drops
    var dropColor = UIColor(red:0.56, green:0.76, blue:0.85, alpha:1.0)
    //initialize the gravity object and UIView
    var gravityBehavior = UIGravityBehavior()
    //creat vars for timers for the 2 rows of rain drops
    var timer1 = NSTimer()
    var timer2 = NSTimer()
    
    func start() {
        // Setup the class
        
        //var for screen width
        var width = self.view.frame.width
        
        // Initialize Values for Position of raindrops and space between them
        startX = 20
        startY = -60
        distanceBetweenEachDrop = width * 0.048
        distanceBetweenSameRow = distanceBetweenEachDrop * 2
        
        // Initialize animator
        self.animator = UIDynamicAnimator(referenceView: self.view)
        gravityBehavior.gravityDirection.dy = 2
        self.animator.addBehavior(gravityBehavior)
        
        //timer that calls spawnFirst method every 0.2 second. Produces rain drops every .2 second in 1st and 2rd row
        timer1 = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "spawnFirst", userInfo: nil, repeats: true)
        //timer that calls startSecond method then waits .1 seconds. Creates a slight delay for 2nd and 4th rows
        var tempTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "startSecond", userInfo: nil, repeats: false)
    }
    
    func startSecond() {
        //calls spawnSecond method every .2 seconds. Produces rain drops every .2 seconds
        timer2 = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "spawnSecond", userInfo: nil, repeats: true)
    }
    
    func addGravity(array: [UIView]) {
        // Adds gravity to every drop in array
        for drop in array {
            gravityBehavior.addItem(drop)
        }
        //Checks if each drop is below the bottom of screen. Then removes its gravity, hides it, and removes from array
        for var i = 0; i < drops.count; i++ {
            if drops[i].frame.origin.y > self.view.frame.height {
                gravityBehavior.removeItem(drops[i])
                drops[i].removeFromSuperview()
                drops.removeAtIndex(i)
            }
        }
    }
    
    //produces the 1st and 3rd columns of drops
    func spawnFirst() {
        //creates array of UIViews (drops)
        var thisArray: [UIView]? = []
        //number of col of drops
        var numberOfDrops = 3

        //for each drop in a row
        for (var i = 0; i < numberOfDrops; i++) {
            // Create a UIView (a drop). Then set the size, color, and remove border of drop
            var newY = CGFloat(-200 + Int(arc4random_uniform(UInt32(150))))
            var newX = CGFloat(10 + Int(arc4random_uniform(UInt32(350))))
            var drop = UIView()
            drop.frame = CGRectMake(newX, newY, 1.0, 50.0)
            drop.backgroundColor = dropColor
            drop.layer.borderWidth = 0.0
            // Add the drop to main view
            self.view.addSubview(drop)
            //add the drop to the drops array
            self.drops.append(drop)
            // Add the drop to thisArray
            thisArray!.append(drop)
        }
        // Adds gravity to the drops that were just created
        addGravity(thisArray!)
    }
    
    //produces the 2nd and 4th columns of drops. Same code as spawnFirst. Runs .1 after spawnFirst.
    func spawnSecond() {
        var thisArray: [UIView] = []
        var numberOfDrops = 3

        
        for (var i = 0; i < numberOfDrops; i++) {
            var newY = CGFloat(-200 + Int(arc4random_uniform(UInt32(150))))
            var newX = CGFloat(10 + Int(arc4random_uniform(UInt32(350))))
            var location = CGFloat(150)
            
            var drop = UIView()
            drop.frame = CGRectMake(newX, newY, 1.0, 50.0)
            drop.backgroundColor = dropColor
            drop.layer.borderWidth = 0.0
            self.view.addSubview(drop)
            self.drops.append(drop)
            thisArray.append(drop)
        }
        
        addGravity(thisArray)
    }
    
    func stop() {
        //removes all objects from drops array
        drops = []
        //stops the 2 timers from spawning drops.
        timer1.invalidate()
        timer2.invalidate()
    }
    
}