//
//  Constructor.swift
//  F1-App
//
//  Created by Vincen Sanjaya on 14/09/26.
//

import Foundation
import SwiftUI

struct Constructor: Identifiable {
    var id: String
    var name: String?
    var fullName: String?
    var themeColor: Color?
    var logoImageName: String?
    var carImageName: String?
    var flag: String?
    
    // Init super fleksibel dengan nilai default
    init(id: String = UUID().uuidString,
         name: String? = nil,
         fullName: String? = nil,
         themeColor: Color? = .gray,
         logoImageName: String? = nil,
         carImageName: String? = nil,
         flag: String? = nil) {
        
        self.id = id
        self.name = name
        self.fullName = fullName
        self.themeColor = themeColor
        self.logoImageName = logoImageName
        self.carImageName = carImageName
        self.flag = flag
    }
}
