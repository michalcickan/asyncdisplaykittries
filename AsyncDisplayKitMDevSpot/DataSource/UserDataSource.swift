//
//  UserDataSource.swift
//  AsyncDisplayKitMDevSpot
//
//  Created by Michal Čičkán on 08/01/2017.
//  Copyright © 2017 Michal Čičkán. All rights reserved.
//

import Foundation

class UserDataSource {
    var parameters = UserRequestParameters()
    var userViewModels = [UserViewModel]()
    
    fileprivate lazy var request : Request<UserListModel> = {
        let req = Request<UserListModel>()
        req.parameters = self.parameters
        
        return req
    }()
    
    func fetchUsers() {
        request.performRequest(completion: { success, userList, error in
            if let users = userList?.users, success {
                self.userViewModels.append(
                    contentsOf:
                    users.map({
                        UserViewModel(userModel: $0)
                    })
                )
                
                print("")
            }
        })
    }
}
