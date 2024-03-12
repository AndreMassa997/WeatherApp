//
//  ForecastDaysViewModel.swift
//  WeatherApp
//
//  Created by Andrea Massari on 12/03/24.
//

import Foundation

final class ForecastDaysViewModel: MVVMViewModel{
    private let data: [ForecastDay]?
    
    init(days: [ForecastDay]?, dataProvider: NetworkProvider){
        self.data = days
        super.init(dataProvider: dataProvider)
    }
    
    
    var dataSource: [ForecastDay]{
        guard let data else {
            return []
        }
        return data.sorted(by: {
            guard let date0 = $0.date.toDate(), let date1 = $1.date.toDate() else {
                return false
            }
            return date0 > date1
        })
    }
    
    func dayForIndex(index: Int) -> ForecastDay?{
        dataSource[safe: index]
    }
}
