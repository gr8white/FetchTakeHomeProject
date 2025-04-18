//
//  RecipeListScreen.swift
//  FetchTakeHomeProject
//
//  Created by Cool-Ish on 4/17/25.
//

import SwiftUI

struct RecipeListScreen: View {
    @Environment(\.networkStore) private var networkStore
    
    let requestURL: URL
    
    @State private var recipes: [Recipe] = []
    @State private var contentState: ContentState = .loading
    @State private var hasFetched: Bool = false
    
    private func fetchData() async {
        do {
            contentState = .loading
            let responseData: RecipeResponse = try await networkStore.fetchData(from: requestURL)
            
            recipes = responseData.recipes.shuffled()
            contentState = .success
        } catch {
            contentState = .failure(.invalidResponse)
        }
    }
    
    var body: some View {
        Group {
            switch contentState {
            case .loading:
                ProgressView()
            case .success:
                if recipes.isEmpty {
                    errorMessage(emoji: "🫥", description: "We couldn't find any recipes. \nPlease change tabs.")
                } else {
                    ScrollView {
                        ForEach(recipes) { recipe in
                            NavigationLink {
                                RecipeDetailView(recipe: recipe)
                            } label: {
                                RecipeCellView(recipe: recipe)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .scrollIndicators(.hidden)
                }
            case .failure(let error):
                errorMessage(emoji: "🤕", description: error.localizedDescription)
            }
        }
        .task {
             if !hasFetched {
                hasFetched = true
                await fetchData()
            }
        }
    }
    
    enum ContentState {
        case loading
        case success
        case failure(NetworkingError)
    }
    
    private func errorMessage(emoji: String, description: String) -> some View {
        GroupBox {
            VStack {
                Text(emoji)
                    .font(.largeTitle)
                
                Text(description)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct RecipeCellView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            ImageLoader(url: recipe.smallPhotoURL)
                .frame(width: 75, height: 75)
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                
                Text(recipe.cuisine)
                    .font(.caption)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
        }
        .padding(.trailing)
        .foregroundStyle(Color.black)
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    NavigationStack{
        RecipeListScreen(requestURL: URLScenario.success.url)
    }
}
