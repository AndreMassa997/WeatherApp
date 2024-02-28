//
//  MVVMViewModel.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import Combine

class MVVMViewModel: ObservableObject {
    let dataProvider: NetworkProvider
    
    init(dataProvider: NetworkProvider){
        self.dataProvider = dataProvider
    }
    
    func bindProperties(){}
    
    var anyCancellables: Set<AnyCancellable> = Set()
}
