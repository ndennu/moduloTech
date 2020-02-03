//
//  Observable.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 31/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//

import Foundation

class MyObservable {
    
    var observers: [MyObserver]?
    
    func subscribe(_ newObserver: MyObserver) -> Int {
        if observers == nil {
            observers = [MyObserver]()
        }
        observers?.append(newObserver)
        return observers!.count
    }
    
    func unsubscribe(_ observerId: Int?) {
        guard let id = observerId else {
            return
        }
        guard var obs = observers else {
            return
        }
        obs.remove(at: id - 1)
        
        if obs.count == 0 {
            observers = nil
        }
    }
    
    func notify() {
        guard let obs = observers else {
            return
        }
        obs.forEach {
            $0.valueChange()
        }
    }
}
