//
//  LoginViewController.swift
//  Repaso2
//
//  Created by Erick Carrasco on 7/5/18.
//  Copyright © 2018 Erick Carrasco. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    let userPreference = UserPreference()
    var userStore = UserStore()
    var email: String? = ""
    var password: String? = ""
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func loginAction(_ sender: UIButton) {
        email = emailInput!.text
        password = passwordInput!.text
        if(email?.isEmpty)! || (password?.isEmpty)!{
            return
        }
        else if isValid() == false{
            return
        }
        else{
            userPreference.user = UserEntity(email: email!, password: password!)
            self.performSegue(withIdentifier: "showMain", sender: self)
        }
    }
    
    func isValid() -> Bool{
        
        if let user = userStore.findUserByEmail(email!) {
            if(user.password == password){
                return true
            } else{
                return false
            }
            
        } else{
            return false
        }
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showRegister", sender: self)
    }
}
