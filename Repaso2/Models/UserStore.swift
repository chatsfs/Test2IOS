//
//  UserStore.swift
//  Repaso2
//
//  Created by Erick Carrasco on 7/5/18.
//  Copyright © 2018 Erick Carrasco. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UserStore {
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let userEntityName = "User"
    
    func save(){
        delegate.saveContext()
    }
        
    func add(for user: UserEntity) -> Bool{
        if findUserByEmail(user.email) != nil {
            return false
        }
        let entityDescription = NSEntityDescription.entity(forEntityName: userEntityName, in: context)
        let userEntity = NSManagedObject(entity: entityDescription!, insertInto: context)
        userEntity.setValue(user.name, forKey: "name")
        userEntity.setValue(user.email, forKey: "email")
        userEntity.setValue(user.password, forKey: "password")
        save()
        return true
    }
    
    func findUserByEmail(_ email: String) -> UserEntity?{
        if let result = findUser(email) {
            let entity = UserEntity(name: result.value(forKey: "name") as! String,
                                    email: result.value(forKey: "email") as! String,
                                    password: result.value(forKey: "password") as! String)
            return entity
        }
        return nil
    }
    
    private func findUser(_ email: String) -> NSManagedObject? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: userEntityName)
        request.predicate = NSPredicate(format: "email = %@", email)
        request.returnsObjectsAsFaults = false
        do{
            let result = try context.fetch(request)
            return result.first as? NSManagedObject
        } catch let error {
            print("Error \(error.localizedDescription)")
        }
        return nil
    }
}
