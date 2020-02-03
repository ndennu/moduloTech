//
//  UserViewModel.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 01/02/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//

import Foundation

class UserViewModel {
    
    private(set) var user: User?
    
    init() {
        user = DbManager.shared.getUser()
    }
    
    func updateUser(firstname: String?,
                    lastName: String?,
                    birthdate: String?,
                    streetCode: String?,
                    street: String?,
                    city: String?,
                    postCode: Int?,
                    country: String?) {
        guard user != nil else {
            return
        }
        
        var changed = false
        
        if let firstname = firstname, firstname != user?.firstName {
            user?.firstName = firstname
            changed = true
        }
        
        if let lastname = lastName, lastname != user?.lastName {
            user?.lastName = lastname
            changed = true
        }
        
        if let birthdate = birthdate?.toDate(), birthdate != user?.birthDate {
            user?.birthDate = birthdate
            changed = true
        }
        
        if let streetcode = streetCode, streetcode != user?.address.streetCode {
            user?.address.streetCode = streetcode
            changed = true
        }
        
        if let street = street, street != user?.address.street {
            user?.address.street = street
            changed = true
        }
        
        if let postcode = postCode, Int32(postcode) != user?.address.postalCode {
            user?.address.postalCode = Int32(postcode)
            changed = true
        }
        
        if let city = city, city != user?.address.city {
            user?.address.city = city
            changed = true
        }
        
        if let country = country, country != user?.address.country {
            user?.address.country = country
            changed = true
        }
        
        if changed {
            saveData()
        }
    }
    
    private func saveData() {
        DbManager.shared.saveData()
    }
    
}
