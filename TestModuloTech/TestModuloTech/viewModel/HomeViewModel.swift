//
//  EquipmentViewModel.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 28/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//

import Foundation

class HomeViewModel: MyObservable {
    
    private(set) var equipment: [Equipment]!
    private(set) var filterEquipment: [Equipment]!
    private(set) var filterOn: ProductType?
    
    func removeEquipment(at index: Int) {
        guard index >= 0 && index < equipment.count else {
            return
        }
        let id = equipment[index].id
        filterEquipment.remove(at: index)
        DbManager.shared.removeEquipment(id: id)
    }
    
    func filter(on type: String) {
        let productType = ProductType(rawValue: type)
        if (productType == filterOn) {
            filterEquipment = equipment
            filterOn = nil
            super.notify()
            return
        }
        filterOn = productType
        filterEquipment = equipment.filter {
            $0.productType == type
        }.map { $0 }
        super.notify()
    }
    
    private func filter() {
        guard filterOn != nil else {
            return
        }
        var stringType: String = ""
        switch filterOn {
        case .Light:
            stringType = ProductType.Light.rawValue
        case .Heater:
            stringType = ProductType.Heater.rawValue
        case .RollerShutter:
            stringType = ProductType.RollerShutter.rawValue
        case .none:
            break
        }
        
        guard stringType != "" else {
            return
        }
        
        filterEquipment = equipment.filter {
            $0.productType == stringType
        }.map { $0 }
        super.notify()
    }
    
    func removefilter() {
        filterEquipment = equipment
        filterOn = nil
        super.notify()
        return
    }
    
    func synchronize() {
        self.equipment = DbManager.shared.getEquipments()
        self.filterEquipment = equipment
        self.filter()
    }
}
