//
//  SettingsViewModel.swift
//  WeatherApp
//
//  Created by Andrea Massari on 12/03/24.
//

import Combine

class LocationsSettingsViewModel: MVVMViewModel {

    @Published private(set) var cities: [Location]
    
    init(cities: [Location], dataProvider: NetworkProvider){
        self.cities = cities
        super.init(dataProvider: dataProvider)
    }
    
    func deleteCity(city: Location){
        self.cities = cities.filter({ $0 != city })
        AppPreferences.shared.savedCities = self.cities
    }
}
