//
//  RandomUsersAPITests.swift
//  RandomUsersAPITests
//
//  Created by Brian Jiménez Moedano on 26/05/23.
//

import XCTest
@testable import RandomUsersAPI

final class RandomUsersAPITests: XCTestCase {
    
    private func getTestJSONData() -> Data {
        
        guard let path = Bundle.main.path(forResource: "randomUsers", ofType: "json") else { fatalError("randomUsers.json file not found") }
        let internalURL = URL(fileURLWithPath: path)
        return try! Data(contentsOf: internalURL)
    }
    
    func testUserModel() throws {
        
        let jsonData = getTestJSONData()
     
        do {
            
          _ = try JSONDecoder().decode(Response.self, from: jsonData)
        }
        catch {
            
          XCTFail("Failed to decode JSON into the model: \(error)")
        }
    }

}
