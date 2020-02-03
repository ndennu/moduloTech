//
//  User+CoreDataClass.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 29/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Decodable {
    
    required public convenience init(from decoder: Decoder) throws {
        guard
            let context = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[context] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.birthDate = Converter.convertMillisecToDate(try container.decode(Int.self, forKey: .birthDate))
        self.address = try container.decode(UserAddress.self, forKey: .address)
    }
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case birthDate
        case address
    }
    
}
