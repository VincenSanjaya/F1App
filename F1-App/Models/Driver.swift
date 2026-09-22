//
//  Driver.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 14/09/26.
//

import Foundation

struct Driver: Identifiable, Codable {
    var id = UUID()
    var driverNumber: Int?
    var fullName: String?
    var nameAcronym: String?
    var teamName: String?
    var teamColour: String?
    var headshotUrl: String?
    var countryCode: String?
    
    init(driverNumber: Int? = nil,
         fullName: String? = nil,
         nameAcronym: String? = nil,
         teamName: String? = nil,
         teamColour: String? = nil,
         headshotUrl: String? = nil,
         countryCode: String? = nil) {
        
        self.driverNumber = driverNumber
        self.fullName = fullName
        self.nameAcronym = nameAcronym
        self.teamName = teamName
        self.teamColour = teamColour
        self.headshotUrl = headshotUrl
        self.countryCode = countryCode
    }

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
