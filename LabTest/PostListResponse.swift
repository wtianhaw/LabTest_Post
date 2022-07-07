//
//  PostListResponse.swift
//  LabTest
//
//  Created by Wong Tian Haw on 06/07/2022.
//

import Foundation

struct PostListResponse: Codable {
    let data: [Datum]?

    enum CodingKeys: String, CodingKey {
        case data
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int?
    let userid: Int?
    let cardid: Int?
    let type: String?
    let name: String?
    let icon: String?
    let description: String?
    let body: String?
    let color: Color?
    let backgroundType: BackgroundType?
    let backgroundUrl: String?
    let liked: Bool?
    let likeCount: Int?
    let viewed: Bool?
    let viewCount: Int?
    let shared: Bool?
    let shareCount: Int?
    let timestamp: String?
    let updatedAt: UpdatedAt?
    let coid: Int?
    let coName: String?
    let coIcon: String?
    let branchAddress: String?
    let branchContact: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userid
        case cardid
        case type
        case name
        case icon
        case description
        case body
        case color
        case backgroundType
        case backgroundUrl
        case liked
        case likeCount
        case viewed
        case viewCount
        case shared
        case shareCount
        case timestamp
        case updatedAt
        case coid
        case coName
        case coIcon
        case branchAddress
        case branchContact
    }
}

enum BackgroundType: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(BackgroundType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for BackgroundType"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Color
struct Color: Codable {
    let bar: Bar?
    let font: Font?

    enum CodingKeys: String, CodingKey {
        case bar
        case font
    }
}

// MARK: - Bar
struct Bar: Codable {
    let top: String?
    let bottom: String?

    enum CodingKeys: String, CodingKey {
        case top
        case bottom
    }
}

// MARK: - Font
struct Font: Codable {
    let icon: String?
    let text: String?

    enum CodingKeys: String, CodingKey {
        case icon
        case text
    }
}

// MARK: - UpdatedAt
struct UpdatedAt: Codable {
    let date: String?
    let timezoneType: Int?
    let timezone: String?

    enum CodingKeys: String, CodingKey {
        case date
        case timezoneType
        case timezone
    }
}
