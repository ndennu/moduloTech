//
//  Light+CoreDataProperties.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 29/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//
//

import Foundation
import CoreData


extension Light {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Light> {
        return NSFetchRequest<Light>(entityName: "Light")
    }

    @NSManaged public var intensity: Int16
    @NSManaged public var mode: Bool

}
