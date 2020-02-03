//
//  devices.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 28/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//

import Foundation

struct DataResult: Decodable {
    
    let devices: [Equipment]?
    let user: User?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var EquipmentsArrayForType = try container.nestedUnkeyedContainer(forKey: .devices)
        var devices = [Equipment]()
        
        var equipmentArray = EquipmentsArrayForType
        while (!EquipmentsArrayForType.isAtEnd) {
            let equipment = try EquipmentsArrayForType.nestedContainer(keyedBy: EquipmentTypeKey.self)
            let type = try equipment.decode(ProductType.self, forKey: EquipmentTypeKey.productType)
            switch type {
            case .Light:
                devices.append(try equipmentArray.decode(Light.self))
            case .Heater:
                devices.append(try equipmentArray.decode(Heater.self))
            case .RollerShutter:
                devices.append(try equipmentArray.decode(RollerShutter.self))
            }
        }
        
        self.user = try container.decode(User.self, forKey: .user)
        
        self.devices = devices
    }
    
    enum CodingKeys: String, CodingKey {
        case devices
        case user
    }
    
    enum EquipmentTypeKey: CodingKey {
        case productType
    }
    
}
