//
//  Date+Ext.swift
//  WeatherApp
//
//  Created by Andrea Massari on 05/02/24.
//

import Foundation

extension Date{
   
    func format(format: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
