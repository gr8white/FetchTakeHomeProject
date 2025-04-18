//
//  NetworkingStore.swift
//  FetchTakeHomeProject
//
//  Created by Cool-Ish on 4/17/25.
//

import Foundation
import SwiftUI

class NetworkingStore {
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
        print("Data stored in cache")
        
        return data
    }
}

enum NetworkingError: Error {
    case decodingFailed(Error)
    case invalidResponse
    case invalidImageData
    case invalidResponseCode(Int)
}
