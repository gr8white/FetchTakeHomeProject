//
//  RecipeDetailView.swift
//  FetchTakeHomeProject
//
//  Created by Cool-Ish on 4/17/25.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    @State private var displayedURL: URL?
    
    var body: some View {
        ScrollView {
            GroupBox {
                VStack(alignment: .leading, spacing: 16) {
                    ImageLoader(url: recipe.largePhotoURL)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .frame(maxWidth: .infinity)
                    
                    HStack {
                        Label("Recipe", systemImage: "fork.knife")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text(recipe.name)
                            .font(.headline)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    Divider()
                    
                    HStack {
                        Label("Cuisine", systemImage: "globe")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text(recipe.cuisine)
                            .font(.body)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    if let sourceURL = recipe.sourceURL {
                        Button {
                            displayedURL = sourceURL
                        } label: {
                            Label("View Source Recipe", systemImage: "doc.text")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
                    if let youtubeURL = recipe.youtubeURL {
                        Button {
                            displayedURL = youtubeURL
                        } label: {
                            Label("Watch YouTube Video", systemImage: "play.rectangle.fill")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding()
            }
            .padding()
        }
        .sheet(item: $displayedURL) { displayedURL in
            SafariView(url: displayedURL)
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(recipe: Recipe.mock)
    }
}
