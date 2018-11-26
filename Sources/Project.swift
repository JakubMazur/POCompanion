//
//  Project.swift
//  POCompanion
//
//  Created by Jakub Mazur on 25/11/2018.
//  Copyright © 2018 Jakub Mazur. All rights reserved.
//

import Cocoa

public class Project: NSObject, Codable {
    private(set) public var identifier: Int
    private(set) public var name: String
    private(set) public var isPublic: Int
    private(set) public var isOpen: Int
    private(set) public var created: Date
    private(set) public var languages: [Language]?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case isPublic = "public"
        case isOpen = "open"
        case created
        case languages
    }
    
    func append(languages: [Language]?) {
        self.languages = languages
    }
}
