//
//  POCompanion.swift
//  POCompanion
//
//  Created by Jakub Mazur on 24/11/2018.
//  Copyright © 2018 Jakub Mazur. All rights reserved.
//

import Cocoa

public class POCompanion: NSObject {
    
    private(set) public var token: String = ""
    internal var networkManager: NetworkManager = NetworkManager()
    
    public init(token: String) {
        super.init()
        self.token = token
    }
    
    public func projects(completion:@escaping([Project]?,Error?) -> Void) {
        networkManager.projects(token: self.token) { (projects, error) in
            completion(projects,error)
        }
    }
    
    public func languages(project: Project, completion:@escaping(Error?) -> Void) {
        networkManager.languages(token: self.token, project: project) { (error) in
            completion(error)
        }
    }
    
    public func project(identifier: Int, completion:@escaping(Error?) -> Void) {
        networkManager.project(projectID: identifier, token: self.token) { (project, error) in
            completion(error)
        }
    }
    
}