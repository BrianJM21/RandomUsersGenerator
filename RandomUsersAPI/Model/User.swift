//
//  User.swift
//  RandomUsersAPI
//
//  Created by Brian Jiménez Moedano on 24/04/23.
//

import Foundation

struct Response: Decodable {
    
    let users: [User]
    
    enum CodingKeys: String, CodingKey {
        
        case users = "results"
    }
}

struct User: Decodable {
    
    let gender: String
    let name: String
    let address: Address
    let email: String
    let login: Login
    let dob: Dob
    let phone: String
    let cell: String
    let picture: Picture
    let nat: String
    
    enum CodingKeys: String, CodingKey {
        
        case gender
        case name
        case location
        case email
        case login
        case dob
        case phone
        case cell
        case picture
        case nat
    }
    
    enum LocationCodingKey: String, CodingKey {
        
        case street
    }
    
    enum StreetCodingKey: String, CodingKey {
        
        case number
        case name
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.gender = try container.decode(String.self, forKey: .gender)
        let name = try container.decode(Name.self, forKey: .name)
        self.name = "\(name.title) \(name.first) \(name.last)"
        let location = try container.decode(Location.self, forKey: .location)
        let streetNumber = try container.nestedContainer(keyedBy: LocationCodingKey.self, forKey: .location).nestedContainer(keyedBy: StreetCodingKey.self, forKey: .street).decode(Int.self, forKey: .number)
        let streetName = try container.nestedContainer(keyedBy: LocationCodingKey.self, forKey: .location).nestedContainer(keyedBy: StreetCodingKey.self, forKey: .street).decode(String.self, forKey: .name)
        self.address = Address(streetNumber: streetNumber, streetName: streetName, city: location.city, state: location.state, country: location.country)
        self.email = try container.decode(String.self, forKey: .email)
        self.login = try container.decode(Login.self, forKey: .login)
        self.dob = try container.decode(Dob.self, forKey: .dob)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.cell = try container.decode(String.self, forKey: .cell)
        self.picture = try container.decode(Picture.self, forKey: .picture)
        self.nat = try container.decode(String.self, forKey: .nat)
    }
}

struct Name: Decodable {
    
    let title: String
    let first: String
    let last: String
}

struct Location: Decodable {
    
    let city: String
    let state: String
    let country: String
    // TODO: El API devuelve String e Int indiscriminadamente
    //let postcode: Int
}

struct Address {
    
    var streetNumber: Int
    var streetName: String
    let city: String
    let state: String
    let country: String
    // TODO: El API devuelve String e Int indiscriminadamente
    //let postcode: Int
}

struct Login: Decodable {
    
    let uuid: String
    let username: String
    let password: String
}

struct Dob: Decodable {
    
    let date: String
    let age: Int
}

struct Picture: Decodable {
    
    let large: String
    let medium: String
    let thumbnail: String
}
