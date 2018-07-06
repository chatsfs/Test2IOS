//
//  UserEntity.swift
//  Repaso2
//
//  Created by Erick Carrasco on 7/5/18.
//  Copyright © 2018 Erick Carrasco. All rights reserved.
//

import Foundation

class  UserEntity {
    
    var name: String
    var email: String
    var password: String
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
    convenience init(email: String, password: String){
        self.init(name: "",
                  email: email,
                  password: password)
    }
    
}
