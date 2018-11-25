//
//  POError.swift
//  POCompanion
//
//  Created by Jakub Mazur on 25/11/2018.
//  Copyright © 2018 Jakub Mazur. All rights reserved.
//

import Foundation

enum POError: Error {
    case invalidURL
    case noData
    case parsingError(_ error: Error)
}
