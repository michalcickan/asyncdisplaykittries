//
//  UserRequestParameters.swift
//  AsyncDisplayKitMDevSpot
//
//  Created by Michal Čičkán on 08/01/2017.
//  Copyright © 2017 Michal Čičkán. All rights reserved.
//

import Foundation
import ObjectMapper

class UserRequestParameters : JSONValue {
    var page : Int
    var perPage : Int
    
    init(page: Int = 1, perPage: Int = 40) {
        self.page = page
        self.perPage = perPage
    }
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        page <- map["page"]
        perPage <- map["results"]
    }
}
