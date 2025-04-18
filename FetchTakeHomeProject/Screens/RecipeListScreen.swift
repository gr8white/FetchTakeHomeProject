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
    @State private var displayedRecipes: [Recipe] = []
    @State private var contentState: ContentState = .loading
    @State private var hasFetched: Bool = false
    @State private var showFilterSheet: Bool = false
    @State private var selectedCuisine: String?
    @State private var cuisineCounts: [String: Int] = [:]
    
    private func fetchData() async {
        do {
            contentState = .loading
            let responseData: RecipeResponse = try await networkStore.fetchData(from: requestURL)
            
            recipes = responseData.recipes.shuffled()
            displayedRecipes = recipes
            cuisineCounts = getCuisineCounts()
            contentState = .success
        } catch {
            contentState = .failure(.invalidResponse)
        }
    }
    
    func filterRecipes() {
        guard let selectedCuisine, selectedCuisine != "All" else {
            displayedRecipes = recipes.shuffled()
            selectedCuisine = nil
            return
        }
        
        displayedRecipes = recipes.filter({ $0.cuisine == selectedCuisine })
    }
    
    func getCuisineCounts() -> [String: Int] {
        var counts: [String: Int] = [:]
        
        for recipe in recipes {
            counts[recipe.cuisine, default: 0] += 1
        }
        
        return counts
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
                        ForEach(displayedRecipes) { recipe in
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
        .sheet(isPresented: $showFilterSheet) {
            filterSheet
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showFilterSheet = true
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                }
                .disabled(recipes.isEmpty)
            }
        }
    }
    
    enum ContentState {
        case loading
        case success
        case failure(NetworkingError)
    }
    
    private var filterSheet: some View {
        NavigationStack {
            VStack {
                Picker("Filter by Cuisine Type", selection: $selectedCuisine) {
                    Text("All").tag("All")
                    ForEach(Array(cuisineCounts.keys), id: \.self) { cuisine in
                        if let count = cuisineCounts[cuisine] {
                            Text("\(cuisine) (\(count))").tag(cuisine)
                        }
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 150)
                
                Button("Apply Filter") {
                    showFilterSheet = false
                    filterRecipes()
                }
            }
            .presentationDetents([.height(250)])
            .navigationTitle("Filter by Cuisine Type")
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    showFilterSheet = false
                } label: {
                    Text("Cancel")
                }
            }
        }
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
    NavigationStack {
        RecipeListScreen(requestURL: URLScenario.success.url)
    }
}
