//
//  RHDirectionManager.swift
//  RHGoogleMapsDirections
//
//  Created by 許郁棋 on 2015/4/26.
//  Copyright (c) 2015年 tinyworld. All rights reserved.
//

import Foundation

class RHDirectionManager {
    
    enum Mode: String {
        case Driving = "driving"
        case Walking = "walking"
        case Bicycling = "bicycling"
        case Transit = "transit"
    }
    
    struct Static {
        static let GetPathDidSuccessNotification = "GetPathDidSuccessNotification"
        static let GetPathDidFailNotification = "GetPathDidFailNotification"
    }
    
    class var sharedManager: RHDirectionManager {
        struct Static {
            static let instance = RHDirectionManager()
        }
        return Static.instance
    }
    var mode: Mode = .Driving
    var path: String?
    
    func getPathFromLocation(location: RHLocation, toLocation: RHLocation) {
        let parameters = [
            "origin": "\(location.latitude), \(location.longitude)",
            "destination": "\(toLocation.latitude), \(toLocation.longitude)",
            "sensor": "true",
            "mode": mode.rawValue
        ]
        
        request(RHDirectionRouter.Directions(parameters: parameters)).responseJSON(options: .allZeros) { _, _, data, error in
            if error == nil {
                if let json = data as? NSDictionary {
                    if let routes = json["routes"] as? Array<AnyObject> {
                        if let firstRoute = routes.first as? NSDictionary {
                            if let overviewPolyline = firstRoute["overview_polyline"] as? NSDictionary {
                                if let points = overviewPolyline["points"] as? String {
                                    self.path = points
                                    NSNotificationCenter.defaultCenter().postNotificationName(Static.GetPathDidSuccessNotification, object: nil)
                                    return
                                }
                            }
                        }
                    }
                }
            }
            else {
                println("Error: \(error!)")
            }
            NSNotificationCenter.defaultCenter().postNotificationName(Static.GetPathDidFailNotification, object: nil)
        }
    }
}