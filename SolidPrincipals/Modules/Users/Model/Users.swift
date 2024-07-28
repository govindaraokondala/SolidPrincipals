//
//  Users.swift
//  Solid
//
//  Created by Govind on 28/07/24.
//

import Foundation
struct User: Codable,Identifiable {
    let address: Address?
    let id: Int
    let email, username, password: String?
    let name: Name?
    let phone: String?
    let v: Int?
}

// MARK: - Address
struct Address: Codable {
    let geolocation: Geolocation?
    let city, street: String?
    let number: Int?
    let zipcode: String?
}

// MARK: - Geolocation
struct Geolocation: Codable {
    let lat, long: String?
}

// MARK: - Name
struct Name: Codable {
    let firstname, lastname: String?
}

typealias users = [User]
