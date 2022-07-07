//
//  PostListRequest.swift
//  LabTest
//
//  Created by Wong Tian Haw on 06/07/2022.
//

import Foundation

class PostListRequest: APIRequestType {
    
    typealias Response = PostListResponse
    
    var path: String = "/api/v2/posts"

    var params: [String: Any] = [:]
    
    var method: APIMethod = .get
}
