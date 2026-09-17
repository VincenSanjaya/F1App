//
//  Driver.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 14/09/26.
//

import Foundation

struct Driver: Identifiable, Codable {
    let id = UUID() // ID lokal untuk SwiftUI
    let driverNumber: Int?
    let fullName: String?
    let nameAcronym: String? // Singkatan nama, misal VER, HAM
    let teamName: String?
    let teamColour: String?
    let headshotUrl: String?
    let countryCode: String?
    
    // Ini jembatan antara nama dari API OpenF1 ke variabel Swift kita
    enum CodingKeys: String, CodingKey {
        case driverNumber = "driver_number"
        case fullName = "full_name"
        case nameAcronym = "name_acronym"
        case teamName = "team_name"
        case teamColour = "team_colour"
        case headshotUrl = "headshot_url"
        case countryCode = "country_code"
    }
}
