//
//  APIServiceModel.swift
//  LabTest
//
//  Created by Wong Tian Haw on 06/07/2022.
//

import Foundation

enum APIMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIEncoding {
    case url
    case json
}

protocol APIRequestType {
    associatedtype Response: Decodable
    
    var path: String { get }
    var params: [String: Any] { get }
    var method: APIMethod { get }
    
}

extension APIRequestType {
    
    func getQueryItems() -> [URLQueryItem]? {
        return self.params.map {
            URLQueryItem(name: $0.0, value: $0.1 as? String)
        }
    }
}
