//
//  RHDirectionRouter.swift
//  RHGoogleMapsDirections
//
//  Created by 許郁棋 on 2015/4/26.
//  Copyright (c) 2015年 tinyworld. All rights reserved.
//

import Foundation

enum RHDirectionRouter: URLRequestConvertible {
    static let baseURLString = "https://maps.googleapis.com/maps/api"
    
    case Directions(parameters: [String: AnyObject])
    
    var method: Method {
        switch self {
        case .Directions(_): return .GET
        }
    }
    
    var path: String {
        switch self {
        case .Directions(_): return "/directions/json"
        }
    }
    
    
    // MARK: - URLRequestConvertible
    
    var URLRequest: NSURLRequest {
        let URL = NSURL(string: RHDirectionRouter.baseURLString)!
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        URLRequest.HTTPMethod = method.rawValue
        
        switch self {
        case .Directions(let parameters):
            return ParameterEncoding.URL.encode(URLRequest, parameters: parameters).0
        default:
            return URLRequest
        }
    }
}