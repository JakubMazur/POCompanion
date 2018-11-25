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
    
    public init(token: String) {
        super.init()
        self.token = token
    }
    
    func projects(completion:@escaping([Project]?,Error?) -> Void) {
        NetworkManager.projects(token: self.token) { (projects, error) in
            completion(projects,error)
        }
    }
    
    func languages(project: Project, completion:@escaping(Error?) -> Void) {
        NetworkManager.languages(token: self.token, project: project) { (error) in
            completion(error)
        }
    }
    
    func project(identifier: Int, completion:@escaping(Error?) -> Void) {
        NetworkManager.project(projectID: identifier, token: self.token) { (project, error) in
            completion(error)
        }
    }
    
}
