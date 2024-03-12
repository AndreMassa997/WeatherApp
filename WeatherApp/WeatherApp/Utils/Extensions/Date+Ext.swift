//
//  Date+Ext.swift
//  WeatherApp
//
//  Created by Andrea Massari on 05/02/24.
//

import Foundation

extension Date{
   
    func format(format: String, withTodayAndTomorrow: Bool = false) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
        guard withTodayAndTomorrow else{
            return dateString
        }
        
        if isToday{
            return "MAIN.APP.TODAY".localized
        }else if isTomorrow{
            return "MAIN.APP.TOMORROW".localized
        }
        return dateString
    }
    
    var hour: Int{
        return Calendar.current.component(.hour, from: self)
    }
    
    var day: Int{
        return Calendar.current.component(.day, from: self)
    }
    
    var isToday: Bool{
        return Calendar.current.component(.day, from: Date()) == self.day
    }
    
    var isTomorrow: Bool{
        return Calendar.current.component(.day, from: Date()) == self.day - 1
    }
}
