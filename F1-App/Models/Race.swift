//
//  Race.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 22/09/26.
//

import Foundation

struct Race: Identifiable {
    var id = UUID()
    var roundNumber: Int
    var countryName: String
    var grandPrixName: String
    var circuitName: String
    var circuitImageName: String // Ini untuk memanggil siluet sirkuit dari Assets
    var date: String
    var isCompleted: Bool
    
    init(roundNumber: Int,
         countryName: String,
         grandPrixName: String,
         circuitName: String,
         circuitImageName: String,
         date: String,
         isCompleted: Bool = false) {
        
        self.roundNumber = roundNumber
        self.countryName = countryName
        self.grandPrixName = grandPrixName
        self.circuitName = circuitName
        self.circuitImageName = circuitImageName
        self.date = date
        self.isCompleted = isCompleted
    }
}
