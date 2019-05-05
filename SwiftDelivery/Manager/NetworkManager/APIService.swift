//
//  APIService.swift
//  SwiftDelivery
//
//  Created by  "" on 12/04/19.
//  Copyright © 2019  "". All rights reserved.
//

import Foundation
import Alamofire

enum APIService {
    
    case deliveries(offset: Int, limit: Int)
    var path: String {
        switch self {
        case .deliveries:
            return "deliveries"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case let .deliveries(offset, limit):
            var params: [String: Any] = ["offset": offset]
            params["limit"] = limit
            return params
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .deliveries:
            return .get
        }
    }
    
    static let baseUrl = AppConfiguration.shared.activeConfiguration.apiEndPoint
}
