//
//  NetworkManager+Requests.swift
//  POCompanion
//
//  Created by Jakub Mazur on 25/11/2018.
//  Copyright © 2018 Jakub Mazur. All rights reserved.
//

import Foundation

extension NetworkManager {
    internal func languages(projectID: Int, completion:@escaping([Language]?,Error?) -> Void) {
        self.detailURL = NetworkManager.RequestURL.languages
        self.parameters = [ParameterKey.token.rawValue: token,
                              ParameterKey.projectID.rawValue: String(projectID)]
        self.method = Method.POST
        _ = self.connect(completion: { (data, response, error) in
            do {
                let parsed = try Parser.from(data: data)
                completion(parsed?.result?.languages, nil)
            } catch {
                completion(nil, POError.parsingError(error))
            }
        })
    }
}

extension NetworkManager {
    internal func export(projectID: Int, language: String, completion:@escaping(URL?,Error?) -> Void) {
        self.detailURL = NetworkManager.RequestURL.export
        self.parameters = [ParameterKey.token.rawValue: token,
                           ParameterKey.projectID.rawValue: String(projectID),
                           ParameterKey.language.rawValue: language,
                           ParameterKey.outputFormat.rawValue: "apple_strings"]
        self.method = Method.POST
        _ = self.connect(completion: { (data, response, error) in
            do {
                let parsed = try Parser.from(data: data)
                if let urlSring = parsed?.result?.url, let url = URL(string: urlSring) {
                    completion(url,nil)
                    return
                }
                completion(nil, POError.gettingFileError)
            } catch {
                completion(nil, POError.parsingError(error))
            }
        })
    }
}

extension NetworkManager {
    internal func downloadResource(language: Language, completion:@escaping(Error?) -> Void) {
        
        guard let langURL = language.languageURL else {
            completion(POError.gettingFileError)
            return
        }
        self.url = langURL
        self.method = Method.GET
        _ = self.downloadResources(from: langURL) { (url, response, error) in
            if let fileURL = url {
                do {
                    language.fileData = try Data(contentsOf: fileURL)
                }
                catch {
                    completion(POError.parsingError(error))
                }
            }
            completion(error)
        }
    }
}
