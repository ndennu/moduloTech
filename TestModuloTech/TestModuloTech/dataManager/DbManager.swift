//
//  DBManager.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 28/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DbManager: MyObservable {
    
    static let shared = DbManager()
    
    private override init() {}
    
    func saveData() {
        let coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            try coreDataContext.save()
        } catch (let err) {
            print("Error save data: \(err.localizedDescription)")
        }
        super.notify()
    }
    
    func getUser() -> User? {
        let coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        var user: User?
        
        do {
            let users = try coreDataContext.fetch(request)
            if users.count > 0 {
                user = users[0]
            }
        } catch {
            print("Fetch user failed from database")
        }
        return user
    }
    
    func getEquipments() -> [Equipment] {
        let coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<Equipment> = Equipment.fetchRequest()
        
        var equipments: [Equipment] = [Equipment]()
        
        do {
            equipments = try coreDataContext.fetch(request)
        } catch {
            print("Fetch equipment failed from database")
        }
        print("equip.count \(equipments.count)")
        return equipments
    }
    
    func removeEquipment(id: Int32) {
        let coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Equipment")
            fetchRequest.predicate = NSPredicate(format: "id = %d", id)
            do {
                let objects = try coreDataContext.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{ $0.map{ coreDataContext.delete($0) } }
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
            } catch let error {
                print("Error deleting Equiment id= \(id) : \(error)")
            }
        }
    }
    
    func clearData() {
        let coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entityNames = ["Equipment", "User"]
        entityNames.forEach {
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: $0)
                do {
                    let objects = try coreDataContext.fetch(fetchRequest) as? [NSManagedObject]
                    _ = objects.map{ $0.map{ coreDataContext.delete($0) } }
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                } catch let error {
                    print("Error deleting \($0) : \(error)")
                }
            }
        }
    }
    
}
