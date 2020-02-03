//
//  RollerShutter+CoreDataProperties.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 29/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//
//

import Foundation
import CoreData


extension RollerShutter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RollerShutter> {
        return NSFetchRequest<RollerShutter>(entityName: "RollerShutter")
    }

    @NSManaged public var position: Int16

}
