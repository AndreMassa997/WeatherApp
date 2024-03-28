//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Andrea Massari on 15/03/24.
//

import Combine

class CityViewModel: MVVMViewModel {
    let city: Location
    let deleteButtonTap = PassthroughSubject<Void, Never>()
    
    init(city: Location, dataProvider: NetworkProvider) {
        self.city = city
        super.init(dataProvider: dataProvider)
    }
}
