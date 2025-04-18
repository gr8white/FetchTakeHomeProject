//
//  RecipeDetailView.swift
//  FetchTakeHomeProject
//
//  Created by Cool-Ish on 4/17/25.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        GroupBox {
            VStack {
                ImageLoader(url: recipe.largePhotoURL)
                
                HStack {
                    Text("Recipe Name:")
                    
                    Spacer()
                    
                    Text(recipe.name)
                }
                
                HStack {
                    Text("Cuisine:")
                    
                    Spacer()
                    
                    Text(recipe.cuisine)
                }
            }
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(recipe: Recipe.mock)
    }
}
