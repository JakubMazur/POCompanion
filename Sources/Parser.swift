//
//  Parser.swift
//  POCompanion
//
//  Created by Jakub Mazur on 25/11/2018.
//  Copyright © 2018 Jakub Mazur. All rights reserved.
//

import Cocoa

class Parser: NSObject {
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        if #available(OSX 10.12, *) {
        decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }()
    
    lazy var endoder: JSONEncoder = {
        let encoder = JSONEncoder()
        if #available(OSX 10.12, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }()
}

extension Parser {
    static func from(data: Data?) throws -> Response? {
        guard let data = data else {
            throw POError.noData
        }
        do {
            let parser = Parser()
            let parsed = try parser.decoder.decode(Response.self, from: data)
            return parsed
        } catch {
            throw error
        }
    }
}
