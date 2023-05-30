//
//  User.swift
//  RandomUsersAPI
//
//  Created by Brian Jiménez Moedano on 29/03/23.
//

import Foundation

class UserData {
    
    var usersData: String?
    var usersArray: [User]?
    
    init(userCount: Int = 10) async {
        
        (usersData, usersArray) = await loadUsers(userCount)
    }
    
    func loadUsers(_ userCount: Int) async -> (String?, [User]?) {
        
        do {
            
            UserFetchingClient.service.userCount = userCount
            let data = try await UserFetchingClient.service.getData()
            let users = try await UserFetchingClient.service.decodeData()
            return (data, users)
        } catch {
            
            print(String(describing: error))
            return (nil, nil)
        }
    }
}
