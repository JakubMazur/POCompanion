//
//  NetworkManager+Requests.swift
//  POCompanion
//
//  Created by Jakub Mazur on 25/11/2018.
//  Copyright © 2018 Jakub Mazur. All rights reserved.
//

import Foundation

extension NetworkManager {
    internal func projects(token: String, completion:@escaping([Project]?,Error?) -> Void) {
        self.detailURL = NetworkManager.RequestURL.projects
        self.parameters = [ParameterKey.token.rawValue: token]
        self.method = Method.POST
        _ = self.connect(request: self.request) { (data, response, error) in
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
    internal func languages(token: String, project: Project, completion:@escaping(Error?) -> Void) {
        self.detailURL = NetworkManager.RequestURL.languages
        self.parameters = [ParameterKey.token.rawValue: token,
                              ParameterKey.projectID.rawValue: String(project.identifier)]
        self.method = Method.POST
        _ = self.connect(request: self.request, completion: { (data, response, error) in
            do {
                let parsed = try Parser.from(data: data)
                project.append(languages: parsed?.result?.languages)
                completion(nil)
            } catch {
                completion(POError.parsingError(error))
            }
        })
    }
}

extension NetworkManager {
    internal func project(projectID: Int, token: String, completion:@escaping(Project?,Error?) -> Void) {
        self.detailURL = NetworkManager.RequestURL.project
        self.parameters = [ ParameterKey.token.rawValue: token,
                               ParameterKey.projectID.rawValue: String(projectID)]
        self.method = Method.POST
        _ = self.connect(request: self.request, completion: { (data, response, error) in
            do {
                let parsed = try Parser.from(data: data)
                completion(parsed?.result?.project, nil)
            } catch {
                completion(nil, POError.parsingError(error))
            }
        })
    }
}
