//
//  SearchCitiesAPI.swift
//  WeatherApp
//
//  Created by Andrea Massari on 28/03/24.
//

import UIKit

struct SearchCitiesAPI: APIElement {
    typealias Output = [Location]
    
    let requestParams: SearchCitiesInput
    
    var path: String{
        "/v1/search.json"
    }
    
    var queryParameters: [(String, Any)]?{
        [("q", requestParams.text)]
    }
    
}

struct SearchCitiesInput{
    let text: String
}
