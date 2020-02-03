//
//  LightViewModel.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 30/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//

import Foundation

class LightViewModel: MyObservable {
    
    private var subscriberId: Int?
    
    private(set) var light: Light
    
    init(from light: Light) {
        self.light = light
    }
    
    func changeMode(_ mode: Bool) {
        guard mode != light.mode else {
            return
        }
        light.mode = mode
        saveData()
    }
    
    func changeIntensity(_ intensity: Int16) {
        guard intensity != light.intensity else {
            return
        }
        light.intensity = intensity
        saveData()
    }
    
    func changeDeviceName(_ deviceName: String) {
        guard deviceName != light.deviceName else {
            return
        }
        light.deviceName = deviceName
        saveData()
    }
    
    private func saveData() {
        subscriberId = DbManager.shared.subscribe(self)
        DbManager.shared.saveData()
    }
}

extension LightViewModel: MyObserver {
    func valueChange() {
        super.notify()
        DbManager.shared.unsubscribe(subscriberId)
    }
}
