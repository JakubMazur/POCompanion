//
//  MockNetworkManager.swift
//  POCompanionTests
//
//  Created by Jakub Mazur on 25/11/2018.
//  Copyright © 2018 Jakub Mazur. All rights reserved.
//

import Cocoa
@testable import POCompanion

class MockNetworkManager: NetworkManager {
    override func connect(request: URLRequest?, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        completion(self.json(), nil, nil)
        return nil
    }
}

extension MockNetworkManager {
    func json() -> Data? {
        guard let requestType = self.detailURL else {
            return nil
        }
        switch requestType {
        case .languages: return self.readJSON(named: "language-list")
        case .projects: return self.readJSON(named: "projects-list")
        case .project: return self.readJSON(named: "projects-view")
        }
    }
    
    func readJSON(named: String) -> Data? {
        if let path = Bundle(for: type(of: self)).path(forResource: named, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                return nil
            }
        }
        return nil
    }
}
