//
//  Recipe.swift
//  FetchTakeHomeProject
//
//  Created by Cool-Ish on 4/17/25.
//

import Foundation

struct Recipe: Decodable {
    let id: String
    let cuisine: String
    let name: String
    let largePhotoString: String?
    let smallPhotoString: String?
    let sourceString: String?
    let youtubeString: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case cuisine
        case name
        case largePhotoString = "photo_url_large"
        case smallPhotoString = "photo_url_small"
        case sourceString = "source_url"
        case youtubeString = "youtube_url"
    }
    
    var largePhotoURL: URL? {
        guard let largePhotoString else { return nil }
        return URL(string: largePhotoString)
    }
    
    var smallPhotoURL: URL? {
        guard let smallPhotoString else { return nil }
        return URL(string: smallPhotoString)
    }
    
    var sourceURL: URL? {
        guard let sourceString else { return nil }
        return URL(string: sourceString)
    }
    
    var youtubeURL: URL? {
        guard let youtubeString else { return nil }
        return URL(string: youtubeString)
    }
}
