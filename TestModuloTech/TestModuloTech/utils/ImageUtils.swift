//
//  ImageUtils.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 30/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//

import UIKit

struct ImageUtils {
    
    static func getImage(fromDiviceType deviceType: ProductType,withMode mode: Bool) -> UIImage {
        switch deviceType {
        case .Light:
            if mode {
                return UIImage(named: "light-on")!
            }
            return UIImage(named: "light-off")!
        case .Heater:
            if mode {
                return UIImage(named: "heater-on")!
            }
             return UIImage(named: "heater-off")!
        default:
            return UIImage(named: "problem")!
        }
    }
    
    static func getImage(fromDiviceType deviceType: ProductType,withPosition position: Int16) -> UIImage {
        switch deviceType {
        case .RollerShutter:
            if position == 0 {
                return UIImage(named: "door-closed")!
            }
            if position == 100 {
                return UIImage(named: "door-open")!
            }
            return UIImage(named: "door-half-open")!
        default:
            return UIImage(named: "problem")!
        }
    }
    
    
    static func getBigImage(fromDiviceType deviceType: ProductType,withMode mode: Bool) -> UIImage {
        switch deviceType {
        case .Light:
            if mode {
                return UIImage(named: "light-on-256")!
            }
            return UIImage(named: "light-off-256")!
        case .Heater:
            if mode {
                return UIImage(named: "heater-on-256")!
            }
             return UIImage(named: "heater-off-256")!
        default:
            return UIImage(named: "problem")!
        }
    }
    
    static func getBigImage(fromDiviceType deviceType: ProductType,withPosition position: Int16) -> UIImage {
        switch deviceType {
        case .RollerShutter:
            if position == 0 {
                return UIImage(named: "door-closed")!
            }
            if position == 100 {
                return UIImage(named: "door-open")!
            }
            return UIImage(named: "door-half-open")!
        default:
            return UIImage(named: "problem")!
        }
    }
}
