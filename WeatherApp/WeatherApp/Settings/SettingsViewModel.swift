//
//  SettingsViewModel.swift
//  WeatherApp
//
//  Created by Andrea Massari on 12/03/24.
//

import UIKit

class SettingsViewModel: MVVMViewModel {

    let cities: [Location]
    
    init(cities: [Location], dataProvider: NetworkProvider){
        self.cities = cities
        super.init(dataProvider: dataProvider)
    }
    
}
