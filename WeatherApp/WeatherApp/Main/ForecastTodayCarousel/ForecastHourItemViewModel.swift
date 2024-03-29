//
//  ForecastHourItemViewModel.swift
//  WeatherApp
//
//  Created by Andrea Massari on 08/02/24.
//

import UIKit

final class ForecastHourItemViewModel: MVVMViewModel{
    private let data: Hour
    @Published var image: UIImage?
    
    init(hour: Hour, dataProvider: NetworkProvider, imagesProvider: ImagesProvider) {
        self.data = hour
        super.init(dataProvider: dataProvider)
        self.imagesProvider = imagesProvider
        self.getImage()
    }
    
    private func getImage(){
        Task{
            self.image = await imagesProvider?.getImage(by: data.condition.icon, cachedImage: true).image
        }
    }
    
    var hourString: String?{
        data.time.toDate()?.format(format: "HH:mm")
    }
    
    var temperatureString: String?{
        let temperatureUnit = AppPreferences.shared.temperatureUnit
        let temperature = temperatureUnit == .celsius ? data.tempC : data.tempF
        return String(format: "%.0f%@", temperature, temperatureUnit.rawValue)
    }
    
}
