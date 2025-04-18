//
//  ContentView.swift
//  FetchTakeHomeProject
//
//  Created by Cool-Ish on 4/17/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedScenario: URLScenario = .empty
    
    var body: some View {
        TabView(selection: $selectedScenario) {
            Tab("Malformed", systemImage: "square.slash", value: .malformed) {
                scenarioTab(.malformed)
            }
            
            Tab("Recipes", systemImage: "square", value: .success) {
                scenarioTab(.success)
            }
            
            Tab("Empty", systemImage: "square.dashed", value: .empty) {
                scenarioTab(.empty)
            }
        }
    }
    
    func scenarioTab(_ scenario:URLScenario) -> some View {
        NavigationStack {
            RecipeListScreen(requestURL: scenario.url)
                .navigationTitle(scenario.title)
        }
    }
}

#Preview {
    ContentView()
}
