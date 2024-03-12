//
//  NetworkManagerProvider.swift
//  WeatherApp
//
//  Created by Andrea Massari on 28/02/24.
//

import UIKit

protocol NetworkProvider{
    func fetchData<T: APIElement>(with apiElement: T) async -> (result: T.Output?, error: ErrorData?)
}

protocol ImagesProvider{
    func getImage(by url: String, cachedImage: Bool) async -> (image: UIImage?, error: ErrorData?)
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
