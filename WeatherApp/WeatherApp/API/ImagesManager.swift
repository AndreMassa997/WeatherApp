//
//  ImagesManager.swift
//  WeatherApp
//
//  Created by Andrea Massari on 28/02/24.
//

import UIKit

struct ImagesManager: ImagesProvider {
    func getImage(by url: String) async -> (image: UIImage?, error: ErrorData?) {
        let url = URL(string: "https:\(url)")
        
        guard let url else {
            print("🔴 Invalid URL")
            return (nil, .invalidURL)
        }
        print("🔵 URL: \(url.absoluteString)")
        
        guard let dataResponse = try? await URLSession.shared.data(from: url) else{
            print("🔴 Invalid Data Error")
            return (nil, .invalidData)
        }
        
        let data = dataResponse.0
        print("🟢 Retrieved image from URL: \(url.absoluteString)")
        
        guard let image = UIImage(data: data) else {
            print("🔴 Decoding image error")
            return (nil, .decodingError)
        }
        
        return (image, nil)
    }
}
