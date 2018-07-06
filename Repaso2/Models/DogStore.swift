//
//  DogStore.swift
//  Repaso2
//
//  Created by Erick Carrasco on 7/5/18.
//  Copyright © 2018 Erick Carrasco. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DogStore {
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dogEntityName = "Favorite"
    
    func save() {
        delegate.saveContext()
    }
    
    func addDog(_ dog: DogEntity, userEmail: String) {
        let entityDescription = NSEntityDescription.entity(forEntityName: dogEntityName, in: context)
        let dogEntity = NSManagedObject(entity: entityDescription!, insertInto: context)
        dogEntity.setValue(dog.dogId, forKey: "dogId")
        dogEntity.setValue(dog.dogImage, forKey: "dogImage")
        dogEntity.setValue(userEmail, forKey: "userEmail")
        save()
       
    }
    
    func deleteDogById(_ dog: DogEntity, userEmail: String){
        let predicate = NSPredicate(format: "dogId = %@ && userEmail = %@", dog.dogId,userEmail)
        if let objectId = findDogBy(predicate: predicate)?.first?.objectID {
            let request = NSBatchDeleteRequest(objectIDs: [objectId])
            do {
                try context.execute(request)
                save()                
            } catch let error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func findDogsByUserEmail (_ userEmail: String) -> [DogEntity]? {
        let predicate = NSPredicate(format: "userEmail = %@", userEmail)
        if let result = findDogBy(predicate: predicate) {
            return result.map({
                let dog = DogEntity(dogId: $0.value(forKey: "dogId") as! String, dogImage: $0.value(forKey: "dogImage") as! String)
                return dog
            })
        }
        return nil
    }
    
    func findDogById (_ dogId: String, userEmail: String) -> DogEntity?{
        let predicate = NSPredicate(format: "dogId = %@ && userEmail = %@", dogId,userEmail)
        if let result = findDogBy(predicate: predicate)?.first {
            let dog = DogEntity(dogId: result.value(forKey: "dogId") as! String,
                                dogImage: result.value(forKey: "dogImage") as! String)
            return dog
        }
        return nil
    }
    
    private func findDogBy(predicate: NSPredicate) -> [NSManagedObject]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dogEntityName)
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        do{
            let result = try context.fetch(request)
            return result as? [NSManagedObject]
            
        } catch let error {
            print("Error \(error.localizedDescription)")
        }
        return nil
    }
    
    func isFavorite(dog: DogEntity, userEmail: String) -> Bool {
        return findDogById(dog.dogId, userEmail: userEmail) != nil
    }
    func favorite(dog: DogEntity,_ userName: String ) {
        setFavorite(true, for: dog,userName)
    }
    func unFavorite(dog: DogEntity,_ userName: String ) {
        setFavorite(false, for: dog,userName)
    }
    
    func setFavorite(_ isFavorite: Bool, for dog: DogEntity,_ userName: String ){
        if isFavorite {
            addDog(dog,userEmail: userName)
            
        } else {
            deleteDogById(dog,userEmail: userName)
            
        }
    }
    
}
