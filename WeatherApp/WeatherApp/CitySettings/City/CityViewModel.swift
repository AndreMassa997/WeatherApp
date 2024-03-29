//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Andrea Massari on 15/03/24.
//

import Combine

class CityViewModel: MVVMViewModel {
    let city: Location
    let rightButtonTap = PassthroughSubject<Void, Never>()
    private let isRightButtonVisible: Bool
    private let isCityAlreadyStored: Bool
    
    init(city: Location, isRightButtonVisible: Bool, isCityAlreadyStored: Bool, dataProvider: NetworkProvider) {
        self.city = city
        self.isCityAlreadyStored = isCityAlreadyStored
        self.isRightButtonVisible = isRightButtonVisible
        super.init(dataProvider: dataProvider)
    }
    
    var locationNameAndFlag: String{
        var name = city.name.capitalized
        if let flag = city.getFlagEmoj{
            name.append(" \(flag)")
        }
        return name
    }
    
    var rightButtonHidden: Bool{
        return !isRightButtonVisible
    }
    
    var rightButtonImageName: String{
        isCityAlreadyStored ? "trash" : "plus"
    }
}
