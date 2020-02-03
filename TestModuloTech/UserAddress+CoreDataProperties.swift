//
//  UserAddress+CoreDataProperties.swift
//  TestModuloTech
//
//  Created by Bérangère La Touche on 03/02/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//
//

import Foundation
import CoreData


extension UserAddress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserAddress> {
        return NSFetchRequest<UserAddress>(entityName: "UserAddress")
    }

    @NSManaged public var city: String
    @NSManaged public var country: String
    @NSManaged public var postalCode: Int32
    @NSManaged public var street: String
    @NSManaged public var streetCode: String
    @NSManaged public var addressOfUser: User

}
