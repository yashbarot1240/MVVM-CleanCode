//
//  ArticlesMedia.swift
//  MVVMDemo
//
//  Created by Yash Barot on 27/12/23.
//

import Foundation


// MARK: - Media
struct ArticlesMedia: Codable {
    var type, subtype, caption, copyright: String?
    var approvedForSyndication: Int?
    var mediaMetadata: [ArticlesMediaMetadatum]?

    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        subtype = try values.decodeIfPresent(String.self, forKey: .subtype)
        caption = try values.decodeIfPresent(String.self, forKey: .caption)
        copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
        approvedForSyndication = try values.decodeIfPresent(Int.self.self, forKey: .approvedForSyndication)
        mediaMetadata = try values.decodeIfPresent([ArticlesMediaMetadatum].self, forKey: .mediaMetadata)
        
        
    }

}
