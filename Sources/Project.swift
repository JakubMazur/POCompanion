//
//  Project.swift
//  POCompanion
//
//  Created by Jakub Mazur on 25/11/2018.
//  Copyright © 2018 Jakub Mazur. All rights reserved.
//

import Cocoa

class Project: NSObject, Codable {
    var identifier: Int
    var name: String
    var isPublic: Int
    var isOpen: Int
    var created: Date
    var languages: [Language]?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case isPublic = "public"
        case isOpen = "open"
        case created
        case languages
    }
}
