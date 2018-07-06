//
//  DogEntity.swift
//  Repaso2
//
//  Created by Erick Carrasco on 7/5/18.
//  Copyright © 2018 Erick Carrasco. All rights reserved.
//

import Foundation
import SwiftyJSON

class DogEntity {
    
    var dogId: String
    var dogImage: String
    
    
    init(dogId: String, dogImage: String) {
        self.dogId = dogId
         self.dogImage = dogImage
    }
    convenience init(from json: JSON){
        self.init(dogId: json["id"].stringValue,
                  dogImage: json["url"].stringValue)
    }
    
    class func builAll(from jsonArray: [JSON]) -> [DogEntity] {
       
        let count = jsonArray.count
        var dogs: [DogEntity] = []
        for i in 0 ..< count {
            dogs.append(DogEntity(from: JSON(jsonArray[i])))
        }
        return dogs
    }
    func isFavorite(userEmail: String) -> Bool {
        let store = DogStore()
        return store.isFavorite(dog: self, userEmail: userEmail)
    }
    func setFavorite(isFavorite: Bool, userEmail: String){
        let store = DogStore()
        store.setFavorite(isFavorite, for: self, userEmail)
    }
}

