//
//  RollerShutterViewModel.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 30/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//

import Foundation

class RollerShutterViewModel: MyObservable {
    
    private var subscriberId: Int?
    
    private(set) var rollerShutter: RollerShutter
    
    init(from roller: RollerShutter) {
        rollerShutter = roller
    }
    
    func changePosition(_ position: Int16) {
        guard position != rollerShutter.position else {
            return
        }
        rollerShutter.position = position
        saveData()
    }
    
    func changeDeviceName(_ deviceName: String) {
        guard deviceName != rollerShutter.deviceName else {
            return
        }
        rollerShutter.deviceName = deviceName
        saveData()
    }
    
    private func saveData() {
        subscriberId = DbManager.shared.subscribe(self)
        DbManager.shared.saveData()
    }
}

extension RollerShutterViewModel: MyObserver {
    func valueChange() {
        super.notify()
        DbManager.shared.unsubscribe(subscriberId)
    }
}
