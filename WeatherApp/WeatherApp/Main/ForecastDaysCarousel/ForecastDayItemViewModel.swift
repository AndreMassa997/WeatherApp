//
//  ForecastDayItemViewModel.swift
//  WeatherApp
//
//  Created by Andrea Massari on 12/03/24.
//

import UIKit

final class ForecastDayItemViewModel: MVVMViewModel{
    private let data: ForecastDay
    @Published var image: UIImage?
    
    init(day: ForecastDay, dataProvider: NetworkProvider, imagesProvider: ImagesProvider) {
        self.data = day
        super.init(dataProvider: dataProvider)
        self.imagesProvider = imagesProvider
        self.getImage()
    }
    
    private func getImage(){
        Task{
            self.image = await imagesProvider?.getImage(by: data.day.condition.icon, cachedImage: true).image
        }
    }
    
    var dayString: String{
        guard let date = data.date.toDate(with: "yyyy-MM-dd") else {
            return data.date
        }
        return date.format(format: "dd/MM", withTodayAndTomorrow: true)
    }
    
    var minTemperatureString: String?{
        String(format: "%.0f°C", data.day.mintempC)
    }
    
    var maxTemperatureString: String?{
        String(format: "%.0f°C", data.day.maxtempC)
    }
    
}
