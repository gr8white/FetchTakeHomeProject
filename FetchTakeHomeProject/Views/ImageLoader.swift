//
//  ImageLoader.swift
//  FetchTakeHomeProject
//
//  Created by Cool-Ish on 4/17/25.
//

import SwiftUI

struct ImageLoader: View {
    @Environment(\.networkStore) private var networkStore
    
    @State private var uiImage: UIImage?
    @State private var contentState: ContentState = .loading
    
    let url: URL?
    
    private func fetchImage() async {
        do {
            guard let url else { return }
            uiImage = try await networkStore.fetchImage(from: url)
            contentState = .loaded(uiImage)
        } catch {
            contentState = .error
        }
    }
    
    var body: some View {
        Group {
            switch contentState {
            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .loaded(let uiImage):
                if let uiImage = uiImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(systemName: "photo.on.rectangle.fill")
                        .resizable()
                        .scaledToFit()
                }
            case .error:
                Image(systemName: "photo.on.rectangle.fill")
                    .resizable()
                    .scaledToFit()
            }
        }
        .task {
            await fetchImage()
        }
    }
    
    enum ContentState {
        case loading
        case loaded(UIImage?)
        case error
    }
}

#Preview {
    ImageLoader(url: Recipe.mock.largePhotoURL)
}
