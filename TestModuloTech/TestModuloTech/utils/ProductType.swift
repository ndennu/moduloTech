//
//  ProductType.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 28/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//

import Foundation

enum ProductType: String, Codable, CaseIterable {
   case Heater = "Heater"
   case Light = "Light"
   case RollerShutter = "RollerShutter"
}
