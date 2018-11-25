//
//  NetworkManagerTests.swift
//  POCompanionTests
//
//  Created by Jakub Mazur on 24/11/2018.
//  Copyright © 2018 Jakub Mazur. All rights reserved.
//

import XCTest
@testable import POCompanion

class NetworkManagerTests: XCTestCase {

    let poeditor: POCompanion = POCompanion(token: <# Your token #>)
    
    func testProjects() {
        let expectation = self.expectation(description: #function)
        poeditor.projects { (projects, error) in
            XCTAssertTrue(projects?.count ?? 0 > 0)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5.0) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testLanguages() {
        let expectation = self.expectation(description: #function)
        poeditor.projects { (projects, error) in
            self.poeditor.languages(project: projects!.first!) { (error) in
                expectation.fulfill()
            }
        }

        self.waitForExpectations(timeout: 5.0) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testProjectView() {
        let expectation = self.expectation(description: #function)
        poeditor.projects { (projects, error) in
            self.poeditor.project(identifier: projects!.first!.identifier, completion: { (error) in
                XCTAssertNil(error)
                expectation.fulfill()
            })
        }
        self.waitForExpectations(timeout: 5.0) { (error) in
            XCTAssertNil(error)
        }
    }

}
