//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Andrea Massari on 15/03/24.
//

import UIKit

class CityViewModel: MVVMViewModel {
    let city: Location
    
    init(city: Location, dataProvider: NetworkProvider) {
        self.city = city
        super.init(dataProvider: dataProvider)
    }
}
