//
//  APIService.swift
//  LabTest
//
//  Created by Wong Tian Haw on 06/07/2022.
//

import Foundation
import Combine
import UIKit

protocol APIServiceType {
    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request: APIRequestType
}

final class APIService: APIServiceType {
    
    let apiLoading: ApiLoading = ApiLoading(loading: false)
    var encoding: APIEncoding = .url
    var uploadPath: String = ""
    private var baseURL: URL?
    private var baseString: String
    
    init() {
        self.baseString = Constant.BASE_URL_STRING
        self.baseURL = URL(string: self.baseString)
    }

    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request: APIRequestType {
        
        if let pathURL = URL(string: request.path, relativeTo: self.baseURL),
           var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true),
           let url: URL = urlComponents.url {
            
            var urlRequest = URLRequest(url: url)
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            //Bearer or Key
            urlRequest.addValue("Bearer \(UserStorage.accessToken)", forHTTPHeaderField: "Authorization")
           
            switch self.encoding {
            case .url:
                urlComponents.queryItems =  request.getQueryItems()
                if let url = urlComponents.url {
                    urlRequest.url = url
                }
            case .json:
                let json = try? JSONSerialization.data(withJSONObject: request.params)
                urlRequest.httpBody = json
            }

            urlRequest.httpMethod = request.method.rawValue

            
            print("Headers: \(String(describing: urlRequest.allHTTPHeaderFields))")
            print("URL: \(String(describing: urlRequest.url))")
            
            self.apiLoading.loading = true
            
            let decorder = JSONDecoder()
            decorder.keyDecodingStrategy = .convertFromSnakeCase
            return URLSession.shared.dataTaskPublisher(for: urlRequest)
                .map { [weak self] data, urlResponse in
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    print("json: \(json ?? "n/a")")
                    
                    self?.apiLoading.loading = false
                    if var jDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let response = urlResponse as? HTTPURLResponse {
                        jDict["code"] = response.statusCode
                        let jData = try? JSONSerialization.data(withJSONObject: jDict)
                        return jData ?? Data()
                    }
                    
                    return data }
                .mapError { _ in APIServiceError.responseError }
                .decode(type: Request.Response.self, decoder: decorder)
                .mapError(APIServiceError.parseError)
                .receive(on: RunLoop.main)
    //            .retry(3)
                .eraseToAnyPublisher()
        }
        
        return Empty().eraseToAnyPublisher()
    }
}
