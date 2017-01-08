//
//  UserDataSource.swift
//  AsyncDisplayKitMDevSpot
//
//  Created by Michal Čičkán on 08/01/2017.
//  Copyright © 2017 Michal Čičkán. All rights reserved.
//

import Foundation

class UserDataSource {
    typealias UserDataSourceCompletiontHandlerType = (_ insertedIndices: [Int]) -> Void
    
    fileprivate var parameters = UserRequestParameters()
    fileprivate lazy var request : Request<UserListModel> = {
        let req = Request<UserListModel>()
        req.parameters = self.parameters
        
        return req
    }()
    
    var userViewModels = [UserViewModel]()
    
    // MARK: - Fetching
    func fetchUsers(completionHandler: UserDataSourceCompletiontHandlerType?) {
        request.performRequest(completion: {[weak self] success, userList, error in
            guard let strongSelf = self else { return }
            
            if let users = userList?.users, success {
                let initialIndex = strongSelf.userViewModels.count
                
                strongSelf.userViewModels.append(
                    contentsOf:
                    users.map({
                        UserViewModel(userModel: $0)
                    })
                )
                let endIndex = strongSelf.userViewModels.count
                if initialIndex < endIndex {
                    completionHandler?(
                        Array(initialIndex..<endIndex)
                    )
                }
            }
        })
    }
    
    func fetchNext(completionHandler: UserDataSourceCompletiontHandlerType?) {
        self.parameters.page += 1
        
        self.fetchUsers(completionHandler: completionHandler)
    }
}
