//
//  ViewController.swift
//  RHGoogleMapsDirections
//
//  Created by 許郁棋 on 2015/4/26.
//  Copyright (c) 2015年 tinyworld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        let start = RHLocation(latitude: 25.046254, longitude: 121.517532)
        let end = RHLocation(latitude: 25.0339031, longitude: 121.5645098)
        RHDirectionManager.sharedManager.getWayPointsFromLocation(start, toLocation: end)
    }
}

