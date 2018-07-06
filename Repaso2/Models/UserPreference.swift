//
//  UserPreference.swift
//  Repaso2
//
//  Created by Erick Carrasco on 7/5/18.
//  Copyright © 2018 Erick Carrasco. All rights reserved.
//

import Foundation

class UserPreference {
    
    let account = UserDefaults.standard
    
    var user: UserEntity? {
        get{
            let userEmail = account.string(forKey: "userEmail")
            let password = account.string(forKey: "password")
            if userEmail == nil && password == nil {
                return nil
            }
            return UserEntity(email: userEmail!, password: password!)
        }
        set{
            if let account = newValue {
                self.account.set(account.email, forKey: "userEmail")
                self.account.set(account.password, forKey: "password")
            }
        }
    }
}
