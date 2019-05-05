//
//  APIServiceRequestManager.swift
//  SwiftDelivery
//
//  Created by  "" on 14/04/19.
//  Copyright © 2019  "". All rights reserved.
//

import Foundation
import Alamofire

protocol APIServiceRequestManagerProtocol {
    func callDeliveryItemService(offset: Int, limit: Int, completion: @escaping ((Result<[DeliveryItem], Error>) -> Void))
}

class APIServiceRequestManager: APIServiceRequestManagerProtocol {
    
    private class func callCommonService<T: Decodable>(service: APIService, completionHandler: @escaping((Result<T, Error>) -> Void)) {
        let url = APIService.baseUrl + service.path
        AF.request(url,
                   method: service.method,
                   parameters: service.parameters).responseDecodable(decoder: JSONDecoder()) { (response: DataResponse<T>)  in
                    completionHandler(response.result)
        }
    }
    
    // Call API to get Intented model
    func callDeliveryItemService(offset: Int, limit: Int, completion: @escaping ((Result<[DeliveryItem], Error>) -> Void)) {
        APIServiceRequestManager.callCommonService(service: APIService.deliveries(offset: offset, limit: limit), completionHandler: completion)
    }
    
}
