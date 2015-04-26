//
//  RHDirectionManager.swift
//  RHGoogleMapsDirections
//
//  Created by 許郁棋 on 2015/4/26.
//  Copyright (c) 2015年 tinyworld. All rights reserved.
//

import Foundation

class RHDirectionManager {
    class var sharedManager: RHDirectionManager {
        struct Static {
            static let instance = RHDirectionManager()
        }
        return Static.instance
    }
    
    func getWayPointsFromLocation(location: RHLocation, toLocation: RHLocation) {
        let parameters = [
            "origin": "\(location.latitude), \(location.longitude)",
            "destination": "\(toLocation.latitude), \(toLocation.longitude)",
            "sensor": "true"
        ]
        
        request(RHDirectionRouter.Directions(parameters: parameters)).responseJSON(options: .allZeros) { _, _, data, error in
            if error == nil {
                println(data)
            }
            else {
                println("Error: \(error!)")
            }
        }
    }
}