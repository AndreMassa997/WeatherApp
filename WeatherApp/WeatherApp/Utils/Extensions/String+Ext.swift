//
//  String+Ext.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import Foundation

extension String{
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func toDate(with format: String = "yyyy-MM-dd HH:mm") -> Date?{
        let df = DateFormatter()
        df.dateFormat = format
        return df.date(from: self)
    }
    
}
