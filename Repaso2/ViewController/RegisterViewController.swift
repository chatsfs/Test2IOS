//
//  RegisterViewController.swift
//  Repaso2
//
//  Created by Erick Carrasco on 7/5/18.
//  Copyright © 2018 Erick Carrasco. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    var userStore = UserStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @IBAction func createAction(_ sender: UIButton) {
        
        let name = nameInput.text
        let email = emailInput.text
        let password = passwordInput.text
        if (name?.isEmpty)! || (email?.isEmpty)! || (password?.isEmpty)! {
            return
        }else{
            if(userStore.add(for: UserEntity(name: name!, email: email!, password: password!))){
                self.dismiss(animated: true)
            }
            else{
                return
            }
        }
    }
}
