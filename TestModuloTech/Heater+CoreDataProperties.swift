//
//  Heater+CoreDataProperties.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 29/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//
//

import Foundation
import CoreData


extension Heater {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Heater> {
        return NSFetchRequest<Heater>(entityName: "Heater")
    }

    @NSManaged public var temperature: Int16
    @NSManaged public var mode: Bool

}
