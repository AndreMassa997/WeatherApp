//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import Foundation
import UIKit

protocol NetworkManagerProvider{
    func getForecastWeather(from location: String, for days: Int) async -> (weather: WeatherModel?, error: ErrorData?)
    func getImage(by url: String) async -> (image: UIImage?, error: ErrorData?)
}

class NetworkManager: NetworkManagerProvider{
    func getForecastWeather(from location: String, for days: Int) async -> (weather: WeatherModel?, error: ErrorData?) {
        return await webCall(with: "forecast.json", params: [("q", location), ("days", days)])
    }
    
    private func webCall<T: MVVMModel>(with url: String, params: [(String, Any)]? = nil, decodingOptions: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase) async -> (T?, ErrorData?){
        let key = "bf4eea9fe44d4ccb96f81437243001"
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.weatherapi.com"
        urlComponents.path = "/v1/\(url)"
        urlComponents.queryItems = params?.compactMap {
            let value = String(describing: $0.1)
            return URLQueryItem(name: $0.0, value: value)
        }
        urlComponents.queryItems?.append(URLQueryItem(name: "key", value: key))
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
        decoder.keyDecodingStrategy = decodingOptions
        let data = dataResponse.0
        print("🟢 Data Retrieved from: \(url.absoluteString) with:\n\(String(data: data, encoding: .utf8)!)")
        
        do{
            let decodedData = try decoder.decode(T.self, from: data)
            return (decodedData, nil)
        }catch let error{
            print("🔴 Decoding error: \(error)")
            return (nil, .decodingError)
        }
    }
    
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

enum ErrorData: Error{
    case invalidURL
    case invalidData
    case decodingError
    
    var description: String{
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidData:
            return "Invalid Data received"
        case .decodingError:
            return "Decoding Error with data"
        }
    }
}
