//
//  APIElement.swift
//  WeatherApp
//
//  Created by Andrea Massari on 28/02/24.
//

import Foundation

protocol APIElement {
    associatedtype Output: Decodable
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryParameters: [(String, Any)]? { get }
    var shouldAddKey: Bool { get }
    var decodingStrategy: JSONDecoder.KeyDecodingStrategy { get }
}

extension APIElement{
    var scheme: String{
        "https"
    }
    var host: String {
        "api.weatherapi.com"
    }
    var shouldAddKey: Bool {
        true
    }
    var decodingStrategy: JSONDecoder.KeyDecodingStrategy{
        .convertFromSnakeCase
    }
}

