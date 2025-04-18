//
//  URLScenario.swift
//  FetchTakeHomeProject
//
//  Created by Cool-Ish on 4/17/25.
//

import Foundation

enum URLScenario {
    case success
    case malformed
    case empty
    
    var title: String {
        switch self {
        case .success: return "Recipes"
        case .malformed: return "Malformed JSON"
        case .empty: return "Empty JSON"
        }
    }
    
    var url: URL {
        var urlString: String
        
        switch self {
        case .success: urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        case .malformed: urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        case .empty: urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
        }
        
        guard let validURL = URL(string: urlString) else {
            fatalError("Invalid URL string: \(urlString)")
        }
        
        return validURL
    }
}
