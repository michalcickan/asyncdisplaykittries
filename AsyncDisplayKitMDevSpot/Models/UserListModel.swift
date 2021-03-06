//
//  UserListModel.swift
//  AsyncDisplayKitMDevSpot
//
//  Created by Michal Čičkán on 08/01/2017.
//  Copyright © 2017 Michal Čičkán. All rights reserved.
//

import ObjectMapper

struct UserListModel: Mappable {
    var users: [UserModel]?
    //var info: [InfoModel]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        users <- map["results"]
    }
}
