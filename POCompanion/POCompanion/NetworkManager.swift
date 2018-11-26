//
//  NetworkManager.swift
//  POCompanion
//
//  Created by Jakub Mazur on 24/11/2018.
//  Copyright © 2018 Jakub Mazur. All rights reserved.
//

import Cocoa

internal class NetworkManager: NSObject {
    
    enum Method: String {
        case POST
        case GET
    }
    
    enum RequestURL: String, CaseIterable {
        case project = "/projects/view"
        case projects = "/projects/list"
        case languages = "/languages/list"
    }
    
    enum ParameterKey: String {
        case token = "api_token"
        case projectID = "id"
    }
    
    internal static let baseURL: String = "https://api.poeditor.com/v2"
    
    internal var detailURL: RequestURL? {
        didSet {
            guard let detail = detailURL?.rawValue else { return }
            self.url = URL(string: (NetworkManager.baseURL + detail))
        }
    }
    
    internal var url: URL? {
        didSet {
            guard let url = url else { return }
            self.request = URLRequest(url: url)
        }
    }
    internal var request: URLRequest?
    internal var queryItems: [URLQueryItem]? {
        didSet {
            var urlComponents = URLComponents()
            urlComponents.queryItems = queryItems
            self.urlComponents = urlComponents.percentEncodedQuery?.data(using: String.Encoding.utf8)
        }
    }
    
    internal var method: Method? {
        didSet {
            request?.httpMethod = method?.rawValue
        }
    }
    internal var urlComponents: Data? {
        didSet {
            self.request?.httpBody = urlComponents
        }
    }
    
    internal let session: URLSession = URLSession(configuration: .default)
    internal var parameters: [String: String]? {
        didSet {
            let queryItems: [URLQueryItem]? = parameters?.map { URLQueryItem(name: $0, value: $1) }
            self.queryItems = queryItems
        }
    }
    
    func connect(request: URLRequest?, completion:@escaping(Data?,URLResponse?,Error?) -> Void) -> URLSessionDataTask? {
        guard let request = request else {
            completion(nil,nil,POError.invalidURL)
            return nil
        }
        let dataTask = self.session.dataTask(with: request) { (data, response, error) in
            completion(data,response,error)
        }
        dataTask.resume()
        return dataTask
    }
}
