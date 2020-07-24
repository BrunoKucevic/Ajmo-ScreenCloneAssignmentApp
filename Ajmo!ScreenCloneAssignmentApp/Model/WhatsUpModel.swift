//
//  WhatsUpModel.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 23/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let whatsUpModel = try? newJSONDecoder().decode(WhatsUpModel.self, from: jsonData)

import Foundation

// MARK: - WhatsUpModel
struct WhatsUpModel: Codable {
    let success: Bool
    let data: [Data]
    let links: Links
    let meta: Meta

    enum CodingKeys: String, CodingKey {
        case success, data
        case links = "_links"
        case meta = "_meta"
    }
}

// MARK: - Datum
struct Data: Codable {
    let id: Int
    let links: [Link]
    let imageURL: String?
    let shareLink: String
    let gallery: [Gallery]
    let isHighlighted: Bool
    let timerFinish: JSONNull?
    let createdAt, updatedAt: Int
    let caption: String
    let isPromoted: Int
    let highlightedText: HighlightedText
    let highlightedIcon: String
    let highlightedGradientColorFirst: HighlightedGradientColorFirst
    let highlightedGradientColorSecond: HighlightedGradientColorSecond
    let title, datumDescription: String

    enum CodingKeys: String, CodingKey {
        case id, links
        case imageURL = "image_url"
        case shareLink = "share_link"
        case gallery, isHighlighted
        case timerFinish = "timer_finish"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case caption
        case isPromoted = "is_promoted"
        case highlightedText = "highlighted_text"
        case highlightedIcon = "highlighted_icon"
        case highlightedGradientColorFirst = "highlighted_gradient_color_first"
        case highlightedGradientColorSecond = "highlighted_gradient_color_second"
        case title
        case datumDescription = "description"
    }
}

// MARK: - Gallery
struct Gallery: Codable {
    let id, newsID: Int
    let picture: String
    let createdAt, updatedAt: Int

    enum CodingKeys: String, CodingKey {
        case id
        case newsID = "news_id"
        case picture
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum HighlightedGradientColorFirst: String, Codable {
    case f76B1C = "#f76b1c"
}

enum HighlightedGradientColorSecond: String, Codable {
    case e6493E = "#e6493e"
}

enum HighlightedText: String, Codable {
    case donTMissThis = "DON'T MISS THIS"
}

// MARK: - Link
struct Link: Codable {
    let id, newsID: Int
    let linkID: Int?
    let linkType: LinkType
    let createdAt, updatedAt: Int

    enum CodingKeys: String, CodingKey {
        case id
        case newsID = "news_id"
        case linkID = "link_id"
        case linkType = "link_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum LinkType: String, Codable {
    case empty = ""
    case event = "event"
    case news = "news"
}

// MARK: - Links
struct Links: Codable {
    let linksSelf, next, last: Last

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case next, last
    }
}

// MARK: - Last
struct Last: Codable {
    let href: String
}

// MARK: - Meta
struct Meta: Codable {
    let totalCount, pageCount, currentPage, perPage: Int
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
