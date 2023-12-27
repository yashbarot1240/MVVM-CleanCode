//
//  ArticlesMediaMetadatum.swift
//  MVVMDemo
//
//  Created by Yash Barot on 27/12/23.
//

import Foundation

// MARK: - MediaMetadatum
struct ArticlesMediaMetadatum: Codable {
    var url: String?
    var format: String?
    var height, width: Int?
    
    enum CodingKeys: String, CodingKey {
        case url, format, height, width
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        format = try values.decodeIfPresent(String.self, forKey: .format)
        height = try values.decodeIfPresent(Int.self.self, forKey: .height)
        width = try values.decodeIfPresent(Int.self.self, forKey: .width)
        
        
        
    }
    
    
}
