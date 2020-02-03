//
//  HeaterViewModel.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 30/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//

import Foundation

class HeaterViewModel: MyObservable{
    
    private var subscriberId: Int?
    
    private(set) var heater: Heater
    
    init(from heater: Heater) {
        self.heater = heater
    }
    
    func changeMode(_ mode: Bool) {
        guard mode != heater.mode else {
            return
        }
        heater.mode = mode
        saveData()
    }
    
    func changeTemperature(_ temp: Int16) {
        guard temp != heater.temperature else {
            return
        }
        heater.temperature = temp
        saveData()
    }
    
    func changeDeviceName(_ deviceName: String) {
        guard deviceName != heater.deviceName else {
            return
        }
        heater.deviceName = deviceName
        saveData()
    }
    
    private func saveData() {
        subscriberId = DbManager.shared.subscribe(self)
        DbManager.shared.saveData()
    }
}

extension HeaterViewModel: MyObserver {
    func valueChange() {
        super.notify()
        DbManager.shared.unsubscribe(subscriberId)
    }
}
