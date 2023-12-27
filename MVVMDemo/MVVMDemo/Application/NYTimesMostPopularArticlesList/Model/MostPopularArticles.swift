//
//  MostPopularArticles.swift
//  MVVMDemo
//
//  Created by Yash Barot on 27/12/23.
//

import Foundation


// MARK: - MostPopularArticles
struct MostPopularArticles: Codable {
    var status, copyright: String?
    var numResults: Int?
    var results: [ArticlesResult]?

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
        numResults = try values.decodeIfPresent(Int.self.self, forKey: .numResults)
        results = try values.decodeIfPresent([ArticlesResult].self, forKey: .results)
        
        
    }
}
