//
//  ForecastHourViewModel.swift
//  WeatherApp
//
//  Created by Andrea Massari on 08/02/24.
//

import UIKit

final class ForecastHoursViewModel: MVVMViewModel{
    private let data: [Hour]?
    
    init(hours: [Hour]?, dataProvider: NetworkProvider) {
        self.data = hours
        super.init(dataProvider: dataProvider)
    }
    
    //Return the current hour + all the hours of the current day
    var dataSource: [Hour]{
        guard let data else {
            return []
        }
        return data.filter({
            guard let date = $0.time.toDate() else { return false }
            return date.hour >= Date().hour
        })
    }
    
}
