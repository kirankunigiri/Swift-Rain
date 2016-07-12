//
//  WaterController.swift
//  Physics
//
//  Created by Kiran Kunigiri on 7/18/15.
//  Copyright (c) 2015 Kiran Kunigiri. All rights reserved.
//

import Foundation
import UIKit

class WaterController {
    
    // MARK: - Properties
    
    // MARK: Views
    var view: UIView!
    private var drops: [UIView] = []
    private var dropColor = UIColor(red:0.56, green:0.76, blue:0.85, alpha:1.0)
    
    // MARK: Drop positions
    private var startX: CGFloat!
    private var startY: CGFloat!
    private var distanceBetweenEachDrop: CGFloat!
    private var distanceBetweenSameRow: CGFloat!
    
    // MARK: Drop behaviors
    private var animator: UIDynamicAnimator!
    private var gravityBehavior = UIGravityBehavior()
    private var timer1 = NSTimer()
    private var timer2 = NSTimer()
    
    // MARK: State
    var isAnimating = false
    
    // MARK: - Methods
    init(view: UIView) {
        // Get main view
        self.view = view
        let width = self.view.frame.width
        
        // Initialize Values for position of raindrops and space between them
        startX = 20
        startY = -60
        distanceBetweenEachDrop = width * 0.048
        distanceBetweenSameRow = distanceBetweenEachDrop * 2
        
        // Initialize animator
        animator = UIDynamicAnimator(referenceView: self.view)
        gravityBehavior.gravityDirection.dy = 2
        animator.addBehavior(gravityBehavior)
    }
    
    /** Starts the rain animation */
    func start() {
        isAnimating = true
        // Timer that calls spawnFirst method every 0.2 second. Produces rain drops every .2 second in 1st and 2rd row
        timer1 = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(spawnFirst), userInfo: nil, repeats: true)
        // Timer that calls startSecond method after .1 seconds. Creates a slight delay for 2nd and 4th rows
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(spawnFirst), userInfo: nil, repeats: false)
    }
    
    /** Starts second timer */
    private func startSecond() {
        timer2 = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(spawnFirst), userInfo: nil, repeats: true)
    }
    
    
    // MARK: - Helper Methods
    
    /** Manages all drops in rain */
    private func addGravity(array: [UIView]) {
        // Adds gravity to every drop in array
        for drop in array {
            gravityBehavior.addItem(drop)
        }
        // Checks if each drop is below the bottom of screen. Then removes its gravity, hides it, and removes from array
        for var i = 0; i < drops.count; i += 1 {
            if drops[i].frame.origin.y > self.view.frame.height {
                gravityBehavior.removeItem(drops[i])
                drops[i].removeFromSuperview()
                drops.removeAtIndex(i)
            }
        }
    }
    
    /** Spawns water drops */
    @objc private func spawnFirst() {
        //creates array of UIViews (drops)
        var thisArray: [UIView] = []
        //number of col of drops
        let numberOfDrops = 3

        //for each drop in a row
        for _ in 0 ..< numberOfDrops {
            // Create a UIView (a drop). Then set the size, color, and remove border of drop
            let newY = CGFloat(-200 + Int(arc4random_uniform(UInt32(150))))
            let newX = CGFloat(10 + Int(arc4random_uniform(UInt32(350))))
            let drop = UIView()
            drop.frame = CGRectMake(newX, newY, 1.0, 50.0)
            drop.backgroundColor = dropColor
            drop.layer.borderWidth = 0.0
            // Add the drop to main view
            self.view.addSubview(drop)
            // Add the drop to the drops array
            self.drops.append(drop)
            // Add the drop to thisArray
            thisArray.append(drop)
        }
        // Adds gravity to the drops that were just created
        addGravity(thisArray)
    }
    
    /** Stops the water animation */
    func stop() {
        isAnimating = false
        // Remove all objects from drops array
        drops.removeAll()
        // Stop all timers
        timer1.invalidate()
        timer2.invalidate()
    }
    
}