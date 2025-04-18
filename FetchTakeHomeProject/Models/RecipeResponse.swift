//
//  RecipeResponse.swift
//  FetchTakeHomeProject
//
//  Created by Cool-Ish on 4/17/25.
//

import Foundation

struct RecipeResponse: Decodable {
    let recipes: [Recipe]
    
    var cuisineCounts: [String: Int] {
        var counts: [String: Int] = [:]
        
        for recipe in recipes {
            counts[recipe.cuisine, default: 0] += 1
        }
        
        return counts
    }
}
