//
//  ResponseResult.swift
//  POCompanion
//
//  Created by Jakub Mazur on 25/11/2018.
//  Copyright © 2018 Jakub Mazur. All rights reserved.
//

import Cocoa

class Response: NSObject, Codable {
    var result: ResponseResult?
}

class ResponseResult: NSObject, Codable {
    var languages: [Language]?
    var url: String?
}
