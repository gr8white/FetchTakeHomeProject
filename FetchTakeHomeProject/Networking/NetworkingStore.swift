//
//  NetworkingStore.swift
//  FetchTakeHomeProject
//
//  Created by Cool-Ish on 4/17/25.
//

import Foundation
import SwiftUI

class NetworkingStore {
    static let shared = NetworkingStore()
    
    func fetchData<T: Decodable>(from url: URL) async throws -> T {
        let data = try await cacheRequest(url)
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkingError.decodingFailed(error)
        }
    }
    
    func fetchImage(from url: URL) async throws -> UIImage {
        let data = try await cacheRequest(url)
        
        guard let image = UIImage(data: data) else {
            throw NetworkingError.invalidImageData
        }
        
        return image
    }
    
    func isCached(url: URL) -> Bool {
        let request = URLRequest(url: url)
        return URLCache.shared.cachedResponse(for: request) != nil
    }
    
    private func cacheRequest(_ url: URL) async throws -> Data {
        let cache = URLCache.shared
        
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkingError.invalidResponse
        }
        
        guard 200..<300 ~= response.statusCode else {
            throw NetworkingError.invalidResponseCode(response.statusCode)
        }
        
        let cachedResponse = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedResponse, for: request)
        
        return data
    }
}

enum NetworkingError: Error {
    case decodingFailed(Error)
    case invalidResponse
    case invalidImageData
    case invalidResponseCode(Int)
    
    var localizedDescription: String {
        switch self {
        case .decodingFailed(let error):
            return "Decoding failed: \(error.localizedDescription)"
        case .invalidResponse:
            return "There was an error parsing the response. \nPlease change tabs."
        case .invalidImageData:
            return "Invalid image data"
        case .invalidResponseCode(let code):
            return "Invalid response code: \(code)"
        }
    }
}
