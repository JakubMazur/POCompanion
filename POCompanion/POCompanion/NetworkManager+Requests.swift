//
//  NetworkManager+Requests.swift
//  POCompanion
//
//  Created by Jakub Mazur on 25/11/2018.
//  Copyright © 2018 Jakub Mazur. All rights reserved.
//

import Foundation

extension NetworkManager {
    internal static func projects(token: String, completion:@escaping([Project]?,Error?) -> Void) {
        let manager: NetworkManager = NetworkManager()
        manager.detailURL = "/projects/list"
        manager.parameters = [ParameterKey.token.rawValue: token]
        manager.method = Method.POST
        _ = manager.connect(request: manager.request) { (data, response, error) in
            do {
                let parsed = try Parser.from(data: data)
                completion(parsed?.result?.projects, nil)
            } catch {
                completion(nil,POError.parsingError(error))
            }
        }
    }
}

extension NetworkManager {
    internal static func languages(token: String, project: Project, completion:@escaping(Error?) -> Void) {
        let manager: NetworkManager = NetworkManager()
        manager.detailURL = "/languages/list"
        manager.parameters = [ParameterKey.token.rawValue: token,
                              ParameterKey.projectID.rawValue: String(project.identifier)]
        manager.method = Method.POST
        _ = manager.connect(request: manager.request, completion: { (data, response, error) in
            do {
                let parsed = try Parser.from(data: data)
                project.languages = parsed?.result?.languages
                completion(nil)
            } catch {
                completion(POError.parsingError(error))
            }
        })
    }
}

extension NetworkManager {
    internal static func project(projectID: Int, token: String, completion:@escaping(Project?,Error?) -> Void) {
        let manager: NetworkManager = NetworkManager()
        manager.detailURL = "/projects/view"
        manager.parameters = [ ParameterKey.token.rawValue: token,
                               ParameterKey.projectID.rawValue: String(projectID)]
        manager.method = Method.POST
        _ = manager.connect(request: manager.request, completion: { (data, response, error) in
            do {
                let parsed = try Parser.from(data: data)
                completion(parsed?.result?.project, nil)
            } catch {
                completion(nil, POError.parsingError(error))
            }
        })
    }
}
