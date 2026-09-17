//
//  Constructor.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 14/09/26.
//

import SwiftUI

struct Constructor: Identifiable {
    let id: String
    let name: String
    let fullName: String
    let themeColor: Color
    let flag: String
    let carImageName: String
    // MARK: - Mapping Otomatis Logo Tim
    var imageName: String {
            return id
        }
    
}

