//
//  Request.swift
//  AsyncDisplayKitMDevSpot
//
//  Created by Michal Čičkán on 08/01/2017.
//  Copyright © 2017 Michal Čičkán. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

protocol JSONValue : Mappable {
    var jsonValue : [String: Any] { get }
}

extension JSONValue {
    var jsonValue : [String: Any] {
        return Mapper().toJSON(self)
    }
}

class Request<T: Mappable> {
    private(set) var parameters : JSONValue?
    var url : String {
        return Config.BaseURL
    }
    typealias RequstCompletionHandler = (_ success: Bool, _ object: T?,_ error: Error?) -> Void
    typealias ObjecType = T
    
    var request : DataRequest {
        let manager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
        return manager.request(
            url,
            parameters: self.parameters?.jsonValue
        )
    }
    
    
    func performRequest(completion: RequstCompletionHandler?) {
        request.responseJSON(
            queue: DispatchQueue.global(),
            options: .allowFragments,
            completionHandler: { response in
                var result : ObjecType?
                var error: Error?
                
                switch response.result {
                case .success(let json):
                    result = Mapper<ObjecType>().map(JSONObject: json)
                    break
                case .failure(let err):
                    error = err
                }
                
                DispatchQueue.main.async {
                    completion?(error == nil, result, error)
                }
        })
        
    }
}
