//
//  PictureModel.swift
//  AsyncDisplayKitMDevSpot
//
//  Created by Michal Čičkán on 08/01/2017.
//  Copyright © 2017 Michal Čičkán. All rights reserved.
//

import Foundation
import ObjectMapper

struct PictureModel: Mappable {
    let large : URL?
    let medium : URL?
    let thumbnail : URL?
    
    init?(map: Map) {
        large = try? map.value("large", using: URLTransform())
        medium = try? map.value("medium", using: URLTransform())
        thumbnail = try? map.value("thumbnail", using: URLTransform())
    }
    
    func mapping(map: Map) {
        
    }
}
