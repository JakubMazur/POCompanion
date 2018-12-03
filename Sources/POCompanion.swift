//
//  POCompanion.swift
//  POCompanion
//
//  Created by Jakub Mazur on 24/11/2018.
//  Copyright © 2018 Jakub Mazur. All rights reserved.
//

import Cocoa

public class POCompanion: NSObject {
    
    private(set) public var token: String
    private(set) public var projectID: Int
    
    internal var networkManager: NetworkManager = NetworkManager.shared
    
    public init(token: String, projectID: Int) {
        self.token = token
        self.projectID = projectID
        NetworkManager.shared.token = self.token
    }
    
    public func fetch(completion:@escaping([Language]?,Error?) -> Void) {
        self.fetchLanguages { (languages, error) in
            guard let languages = languages, error == nil else {
                completion(nil, error ?? POError.invalidLocalizables)
                return
            }
            self.fetchTranslations(languages: languages, completion: { (error) in
                guard error == nil else {
                    completion(nil, error ?? POError.invalidLocalizables)
                    return
                }
                self.downloadFiles(languages: languages, completion: { (error) in
                    guard error == nil else {
                        completion(nil, error ?? POError.invalidLocalizables)
                        return
                    }
                    completion(languages,nil)
                })
            })
        }
    }
    
    func downloadFiles(languages: [Language], completion:@escaping(Error?) -> Void) {
        for language in languages {
            networkManager.downloadResource(language: language) { (error) in
                if error != nil {
                    completion(error ?? POError.invalidLocalizables)
                    return
                } else {
                    let filtered = languages.filter { $0.fileData == nil }
                    if filtered.isEmpty {
                        completion(nil)
                    }
                }
            }
        }
    }
    
    func fetchTranslations(languages: [Language], completion:@escaping(Error?) -> Void) {
        for lang in languages {
            self.fetchTranslation(for: lang, completion: { (error) in
                if error != nil {
                    completion(error)
                    return
                } else {
                    let filtered = languages.filter { $0.languageURL == nil }
                    if filtered.isEmpty {
                        completion(nil)
                    }
                }
            })
        }
    }
    
    func fetchLanguages(completion:@escaping([Language]?, Error?) -> Void) {
        networkManager.languages(projectID: self.projectID) { (languages, error) in
            completion(languages,error)
        }
    }
    
    func fetchTranslation(for language: Language?, completion:@escaping(Error?) -> Void) {
        guard let language = language else {
            completion(POError.gettingFileError)
            return
        }
        networkManager.export(projectID: self.projectID, language: language.code) { (url, error) in
            guard let url = url, error == nil else {
                completion(error ?? POError.gettingFileError)
                return
            }
            language.languageURL = url
            completion(nil)
        }
    }

}
