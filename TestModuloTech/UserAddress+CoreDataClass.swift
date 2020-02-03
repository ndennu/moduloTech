//
//  UserAddress+CoreDataClass.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 29/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//
//

import Foundation
import CoreData

@objc(UserAddress)
public class UserAddress: NSManagedObject, Decodable {

    required public convenience init(from decoder: Decoder) throws {
        guard
            let context = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[context] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "UserAddress", in: managedObjectContext) else {
            fatalError("Failed to decode UserAddress")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.city = try container.decode(String.self, forKey: .city)
        self.postalCode = try container.decode(Int32.self, forKey: .postalCode)
        self.street = try container.decode(String.self, forKey: .street)
        self.streetCode = try container.decode(String.self, forKey: .streetCode)
        self.country = try container.decode(String.self, forKey: .country)
    }
    
    enum CodingKeys: String, CodingKey {
        case city
        case postalCode
        case street
        case streetCode
        case country
    }
    
}
