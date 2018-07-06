//
//  ProgressViewController.swift
//  Repaso2
//
//  Created by Erick Carrasco on 7/5/18.
//  Copyright © 2018 Erick Carrasco. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ProgressViewController: UIViewController {
    
    @IBOutlet weak var progressBarView: UIProgressView!
    
    var allDogss: Int = 50
    var myDogs: Int = 0
    let favoriteStore = DogStore()
    let userPreference = UserPreference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        
        print(myDogs)
        print(allDogss)
        let result: Float = Float((myDogs * 100)/allDogss)
        print(result)
        progressBarView.setProgress(result, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
        let result: Float = Float(myDogs/allDogss)
        progressBarView.progress = result
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateData(){
        myDogs = favoriteStore.findDogsByUserEmail((userPreference.user?.email)!)!.count
    }
}
