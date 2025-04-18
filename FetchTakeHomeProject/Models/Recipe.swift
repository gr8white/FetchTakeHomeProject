//
//  Recipe.swift
//  FetchTakeHomeProject
//
//  Created by Cool-Ish on 4/17/25.
//

import Foundation

struct Recipe: Decodable, Identifiable {
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

extension Recipe {
    static var mock: Recipe {
        Recipe(
            id: "cf8cbc60-2fce-4af8-8317-1736e9e116d1",
            cuisine: "American",
            name: "Peach & Blueberry Grunt",
            largePhotoString: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/483a686e-8f97-4139-b575-1c154d542b10/large.jpg",
            smallPhotoString: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/483a686e-8f97-4139-b575-1c154d542b10/small.jpg",
            sourceString: "https://www.bbcgoodfood.com/recipes/1553651/peach-and-blueberry-grunt",
            youtubeString: "https://www.youtube.com/watch?v=SNeO28BCpsc"
        )
    }
}
