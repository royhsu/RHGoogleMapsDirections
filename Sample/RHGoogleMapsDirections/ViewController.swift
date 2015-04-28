//
//  ViewController.swift
//  RHGoogleMapsDirections
//
//  Created by 許郁棋 on 2015/4/26.
//  Copyright (c) 2015年 tinyworld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: RHDirectionManager.Static.GetPathDidSuccessNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: RHDirectionManager.Static.GetPathDidFailNotification, object: nil)
    }

    
    // MARK: - Setup
    
    func setup() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "getPathDidSuccessNotification:", name: RHDirectionManager.Static.GetPathDidSuccessNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "getPathDidFailNotification:", name: RHDirectionManager.Static.GetPathDidFailNotification, object: nil)
        
        let start = RHLocation(latitude: 25.046254, longitude: 121.517532)
        let end = RHLocation(latitude: 25.0339031, longitude: 121.5645098)
        
        // Specify what the mode you want. (Default is .Driving)
        RHDirectionManager.sharedManager.mode = .Walking
        RHDirectionManager.sharedManager.getPathFromLocation(start, toLocation: end)
    }
    
    
    // MARK: - Action
    
    private dynamic func getPathDidSuccessNotification(sender: AnyObject?) {
        if let path = RHDirectionManager.sharedManager.path {
            println(path)
        }
    }
    
    private dynamic func getPathDidFailNotification(sender: AnyObject?) {
        println("Failed to get path.")
    }
}

