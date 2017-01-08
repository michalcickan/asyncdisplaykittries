//
//  UserDataSource.swift
//  AsyncDisplayKitMDevSpot
//
//  Created by Michal Čičkán on 08/01/2017.
//  Copyright © 2017 Michal Čičkán. All rights reserved.
//

import Foundation

class UserDataSource {
    lazy var request = {
        return Request<UserListModel>()
    }()
}
