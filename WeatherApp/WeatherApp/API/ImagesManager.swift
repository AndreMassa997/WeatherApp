//
//  ImagesManager.swift
//  WeatherApp
//
//  Created by Andrea Massari on 29/02/24.
//

import UIKit

struct ImagesManager: ImagesProvider {
    private let imageCache = URLCache(memoryCapacity: 0, diskCapacity: 200*1024*1024, diskPath: "PokeDexAPICache")
    
    func getImage(by url: String, cachedImage: Bool) async -> (image: UIImage?, error: ErrorData?) {
        let url = URL(string: "https:\(url)")
        
        guard let url else {
            print("🔴 Invalid URL")
            return (nil, .invalidURL)
        }
        print("🔵 URL: \(url.absoluteString)")
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = .returnCacheDataElseLoad
        sessionConfiguration.urlCache = imageCache
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        
        if let imageData = imageCache.cachedResponse(for: request)?.data, let image = UIImage(data: imageData){
            print("🟠 Cached Image from URL \(url.absoluteString)")
            return (image, nil)
        }
        
        guard let dataResponse = try? await URLSession(configuration: sessionConfiguration).data(for: request) else{
            print("🔴 Invalid Data Error")
            return (nil, .invalidData)
        }
        
        let data = dataResponse.0
        print("🟢 Retrieved image from URL: \(url.absoluteString)")
        
        guard let image = UIImage(data: data) else {
            print("🔴 Decoding image error")
            return (nil, .decodingError)
        }
        
        if cachedImage{
            imageCache.storeCachedResponse(CachedURLResponse(response: dataResponse.1, data: dataResponse.0), for: request)
        }
        
        return (image, nil)
    }
}
