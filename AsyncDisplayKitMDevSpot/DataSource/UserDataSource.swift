//
//  UserDataSource.swift
//  AsyncDisplayKitMDevSpot
//
//  Created by Michal Čičkán on 08/01/2017.
//  Copyright © 2017 Michal Čičkán. All rights reserved.
//

import Foundation

class UserDataSource {
    fileprivate var parameters = UserRequestParameters()
    var userViewModels = [UserViewModel]()
    
    fileprivate lazy var request : Request<UserListModel> = {
        let req = Request<UserListModel>()
        req.parameters = self.parameters
        
        return req
    }()
    
    func fetchUsers() {
        request.performRequest(completion: {[weak self] success, userList, error in
            guard let strongSelf = self else { return }
            
            if let users = userList?.users, success {
                strongSelf.userViewModels.append(
                    contentsOf:
                    users.map({
                        UserViewModel(userModel: $0)
                    })
                )
                
                print("")
            }
        })
    }
    
    func fetchNext() {
        self.parameters.page += 1
        
        self.fetchUsers()
    }
}
