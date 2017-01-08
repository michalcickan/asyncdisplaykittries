//
//  UserViewModel.swift
//  AsyncDisplayKitMDevSpot
//
//  Created by Michal Čičkán on 08/01/2017.
//  Copyright © 2017 Michal Čičkán. All rights reserved.
//

import Foundation

enum PhotoQualityEnum {
    case Medium, Full, Thumbnail
}

protocol UserViewModelProtocol {
    var fullName : String { get }
    var description: String { get }
    var email: String { get }
    var aboutText: String { get }
    var genderText: String { get }
    
    func photoUrl(quality: PhotoQualityEnum) -> URL?
    
}

class UserViewModel : UserViewModelProtocol {
    let userModel: UserModel
    
    init(userModel: UserModel) {
        self.userModel = userModel
    }
    
    internal func photoUrl(quality: PhotoQualityEnum) -> URL? {
        guard let picture = userModel.pictureModel else { return nil }
        
        switch quality {
        case .Full:
            return picture.large
        case .Medium:
            return picture.medium
        default:
            return picture.thumbnail
        }
    }
    internal var genderText: String {
        guard let gender = userModel.gender else { return "shemale" }
        
        switch gender {
        case "male":
            return "woman"
        default:
            return "man"
        }
    }
    internal var aboutText: String {
        let regString = userModel.registered!
        return "\(self.fullName) is \(self.userModel.gender!) and is very good painter as all people here. We noticed that great day, when he joined us on \(regString) \(self.fullName) doesn't need any letter box because we can reach \(self.fullName) at \(userModel.email!). Isn't it good to not kill woods? Apple Liam can be an example of good approach to environment. Howgh"
    }
    
    internal var email: String {
        return userModel.email ?? ""
    }
    
    internal var description: String {
        var desc = [String]()
        
        if let gender = userModel.gender {
            desc.append(gender)
        }
        
        if let nationality = userModel.nationality {
            desc.append(nationality)
        }
        
        return desc.joined(separator: " / ")
    }
    
    internal var fullName: String {
        guard let name = userModel.nameModel else { return ""}
        
        return "\(name.name!) \(name.surname!)"
    }

}
