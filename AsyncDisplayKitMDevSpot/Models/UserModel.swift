//
//  UserModel.swift
//  AsyncDisplayKitMDevSpot
//
//  Created by Michal Čičkán on 08/01/2017.
//  Copyright © 2017 Michal Čičkán. All rights reserved.
//

import Foundation
import ObjectMapper
/*
 {
 "gender": "male",
 "name": {
 "title": "mr",
 "first": "romain",
 "last": "hoogmoed"
 },
 "location": {
 "street": "1861 jan pieterszoon coenstraat",
 "city": "maasdriel",
 "state": "zeeland",
 "postcode": 69217
 },
 "email": "romain.hoogmoed@example.com",
 "login": {
 "username": "lazyduck408",
 "password": "jokers",
 "salt": "UGtRFz4N",
 "md5": "6d83a8c084731ee73eb5f9398b923183",
 "sha1": "cb21097d8c430f2716538e365447910d90476f6e",
 "sha256": "5a9b09c86195b8d8b01ee219d7d9794e2abb6641a2351850c49c309f1fc204a0"
 },
 "dob": "1983-07-14 07:29:45",
 "registered": "2010-09-24 02:10:42",
 "phone": "(656)-976-4980",
 "cell": "(065)-247-9303",
 "id": {
 "name": "BSN",
 "value": "04242023"
 },
 "picture": {
 "large": "https://randomuser.me/api/portraits/men/83.jpg",
 "medium": "https://randomuser.me/api/portraits/med/men/83.jpg",
 "thumbnail": "https://randomuser.me/api/portraits/thumb/men/83.jpg"
 },
 "nat": "NL"
 }
 */
struct UserModel: Mappable {
    let gender: String?
    let email : String?
    let phone : String?
    let nationality: String?
    let pictureModel : PictureModel?
    let userName : String?
    let id : String?
    let nameModel: NameModel?
    let registered: String?
    
    init?(map: Map) {
        gender = try? map.value("gender")
        email = try? map.value("email")
        phone = try? map.value("phone")
        nationality = try? map.value("nat")
        pictureModel = try? map.value("picture")
        userName = try? map.value("username")
        id = try? map.value("id.value")
        nameModel = try? map.value("name")
        registered = map["registered"].value()
    }
 
    mutating func mapping(map: Map) {
 
    }
}
