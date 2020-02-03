//
//  Equipment+CoreDataClass.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 29/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Equipment)
public class Equipment: NSManagedObject, Decodable {
    
    public required convenience init(from decoder: Decoder) throws {
        guard
            let context = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[context] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Equipment", in: managedObjectContext) else {
                fatalError("Failed to decode Equipment")
        }

        self.init(entity: entity, insertInto: managedObjectContext)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case deviceName
        case productType
    }
    
}
