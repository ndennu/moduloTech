//
//  Heater+CoreDataClass.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 29/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Heater)
public class Heater: Equipment {

    required convenience init(from decoder: Decoder) throws {
        
        guard
            let context = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[context] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Heater", in: managedObjectContext) else {
                fatalError("Failed to decode Heater")
        }
        
        let container = try decoder.container(keyedBy: CodingKeysHeater.self)
        let parentContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.init(entity: entity, insertInto: managedObjectContext)
        

        self.id = try parentContainer.decode(Int32.self, forKey: .id)
        self.deviceName = try parentContainer.decode(String.self, forKey: .deviceName)
        self.productType = try parentContainer.decode(String.self, forKey: .productType)
        self.temperature = try container.decode(Int16.self, forKey: .temperature)
        self.mode = Converter.convertStatusValueToBool(try container.decode(String.self, forKey: .mode))
    }
    
    enum CodingKeysHeater: String, CodingKey {
        case temperature
        case mode
    }
    
}
