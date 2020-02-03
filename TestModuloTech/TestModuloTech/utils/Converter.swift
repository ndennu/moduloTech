//
//  Converter.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 29/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//

import Foundation

enum DateFormatterString: String {
    case dateEN = "MM/dd/yyyy"
    case dateFR = "dd/MM/yyyy"
}

struct Converter {
    
    static func convertStatusValueToBool(_ value: String) -> Bool {
        if ("ON" == value) {
            return true
        } else {
            return false
        }
    }
    
    static func convertMillisecToDate(_ value: Int) -> Date {
        return TimeInterval(value).toDate()
    }
    
}

extension TimeInterval {
    
    func toDate() -> Date {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        return date
    }
}

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatterString.dateFR.rawValue
        formatter.timeZone = .current
        return formatter.string(from: self)
    }
}

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        return formatter.date(from: self)
    }
}
