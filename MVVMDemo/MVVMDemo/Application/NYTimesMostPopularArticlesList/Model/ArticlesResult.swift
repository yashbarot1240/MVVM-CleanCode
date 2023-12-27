//
//  ArticlesResult.swift
//  MVVMDemo
//
//  Created by Yash Barot on 27/12/23.
//

import Foundation


// MARK: - Result
struct ArticlesResult: Codable {
    var uri: String?
    var url: String?
    var id, assetID: Int?
    var source, publishedDate, updated, section: String?
    var subsection, nytdsection, adxKeywords: String?
    var byline, type, title, abstract: String?
    var desFacet, orgFacet, perFacet, geoFacet: [String]?
    var media: [ArticlesMedia]?
    var etaID: Int?

    enum CodingKeys: String, CodingKey {
        case uri, url, id
        case assetID = "asset_id"
        case source
        case publishedDate = "published_date"
        case updated, section, subsection, nytdsection
        case adxKeywords = "adx_keywords"
        case byline, type, title, abstract
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media
        case etaID = "eta_id"
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        uri = try values.decodeIfPresent(String.self, forKey: .uri)
        url = try values.decodeIfPresent(String.self, forKey: .uri)
        
        id = try values.decodeIfPresent(Int.self.self, forKey: .id)
        assetID = try values.decodeIfPresent(Int.self.self, forKey: .assetID)
        
        source = try values.decodeIfPresent(String.self, forKey: .source)
        publishedDate = try values.decodeIfPresent(String.self, forKey: .publishedDate)
        updated = try values.decodeIfPresent(String.self, forKey: .updated)
        section = try values.decodeIfPresent(String.self, forKey: .section)
        subsection = try values.decodeIfPresent(String.self, forKey: .subsection)
        nytdsection = try values.decodeIfPresent(String.self, forKey: .nytdsection)
        adxKeywords = try values.decodeIfPresent(String.self, forKey: .adxKeywords)
        byline = try values.decodeIfPresent(String.self, forKey: .byline)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        abstract = try values.decodeIfPresent(String.self, forKey: .abstract)
        
        desFacet = try values.decodeIfPresent([String].self, forKey: .desFacet)
        orgFacet = try values.decodeIfPresent([String].self, forKey: .orgFacet)
        perFacet = try values.decodeIfPresent([String].self, forKey: .perFacet)
        geoFacet = try values.decodeIfPresent([String].self, forKey: .geoFacet)
        
        media = try values.decodeIfPresent([ArticlesMedia].self, forKey: .media)
        etaID = try values.decodeIfPresent(Int.self, forKey: .etaID)
        
        
    }
    
}
