//
//  NameModel.swift
//  AsyncDisplayKitMDevSpot
//
//  Created by Michal Čičkán on 08/01/2017.
//  Copyright © 2017 Michal Čičkán. All rights reserved.
//

import UIKit
import ObjectMapper

struct NameModel: Mappable {
    let title: String?
    let name: String?
    let surname: String?
    
    init?(map: Map) {
        title = map["title"].value()
        name = map["first"].value()
        surname = map["last"].value()
    }
    
    func mapping(map: Map) {
        
    }
}
