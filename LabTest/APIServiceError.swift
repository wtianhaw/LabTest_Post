//
//  APIServiceError.swift
//  LabTest
//
//  Created by Wong Tian Haw on 06/07/2022.
//

import Foundation

enum APIServiceError: Error {
    case responseError
    case parseError(Error)
    case apiError
}

struct ApiErrorMsg: Decodable, Hashable {
    var status: Bool
    var code: Int
    var msg: String
}
