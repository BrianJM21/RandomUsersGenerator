//
//  UserFetchingClient.swift
//  RandomUsersAPI
//
//  Created by Brian Jiménez Moedano on 03/04/23.
//

import Foundation

class UserFetchingClient {
    
    static let service = UserFetchingClient()
    var userCount: Int = 10
    private var url: URL {
        
        return URL(string: "https://randomuser.me/api/?results=\(userCount)&format=pretty")!
    }
    private var dataFetched: Data?
    
    func getData() async throws -> String? {
        
        async let (data, _) = try URLSession.shared.data(from: url)
        try await dataFetched = data
        return try await String(data: data, encoding: .utf8)
    }
    
    func decodeData() async throws -> [User]? {
        
        guard let dataFetched else { return nil }
        return try JSONDecoder().decode(Response.self, from: dataFetched).users
    }
}
