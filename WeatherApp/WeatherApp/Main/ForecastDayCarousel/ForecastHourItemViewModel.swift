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
    private let imagesProvider: ImagesProvider
    
    init(hour: Hour, dataProvider: NetworkProvider, imagesProvider: ImagesProvider) {
        self.data = hour
        self.imagesProvider = imagesProvider
        super.init(dataProvider: dataProvider)
        self.getImage()
    }
    
    private func getImage(){
        Task{
            self.image = await imagesProvider.getImage(by: data.condition.icon).image
        }
    }
    
    var hourString: String?{
        data.time.toDate()?.format(format: "HH:mm")
    }
    
    var temperatureString: String?{
        String(format: "%.0f°C", data.tempC)
    }
    
}
