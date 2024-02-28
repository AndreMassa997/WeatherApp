//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import Foundation
import UIKit

struct NetworkManager: NetworkProvider{
    private let key = "bf4eea9fe44d4ccb96f81437243001"

    func fetchData<T: APIElement>(with apiElement: T) async -> (result: T.Output?, error: ErrorData?) where T: APIElement {
        var urlComponents = URLComponents()
        urlComponents.scheme = apiElement.scheme
        urlComponents.host = apiElement.host
        urlComponents.path = apiElement.path
        urlComponents.queryItems = apiElement.queryParameters?.compactMap {
            let value = String(describing: $0.1)
            return URLQueryItem(name: $0.0, value: value)
        }
        if apiElement.shouldAddKey{
            urlComponents.queryItems?.append(URLQueryItem(name: "key", value: self.key))
        }
        guard let url = urlComponents.url else {
            print("🔴 Invalid URL")
            return (nil, .invalidURL)
        }
        print("🔵 URL: \(url.absoluteString)")
        
        guard let dataResponse = try? await URLSession.shared.data(from: url) else{
            print("🔴 Invalid Data Error")
            return (nil, .invalidData)
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = apiElement.decodingStrategy
        let data = dataResponse.0
        print("🟢 Data Retrieved from: \(url.absoluteString) with:\n\(String(data: data, encoding: .utf8)!)")
        
        do{
            let decodedData = try decoder.decode(T.Output.self, from: data)
            return (decodedData, nil)
        }catch let error{
            print("🔴 Decoding error: \(error)")
            return (nil, .decodingError)
        }
    }
}
