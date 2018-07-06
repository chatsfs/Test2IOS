//
//  AboutViewController.swift
//  Repaso2
//
//  Created by Erick Carrasco on 7/5/18.
//  Copyright © 2018 Erick Carrasco. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogIdLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var isFavorite: Bool = false
    
    let dogStore = DogStore()
    var dogEntry: DogEntity?
    let userPreference = UserPreference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dog = dogEntry{
            dogIdLabel.text = dog.dogId
            if let url = URL(string: dog.dogImage){
                dogImageView.af_setImage(withURL: url)
            }
            isFavorite = (dogEntry?.isFavorite(userEmail: (userPreference.user?.email)!))!
            setFavoriteImage()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        isFavorite = (dogEntry?.isFavorite(userEmail: (userPreference.user?.email)!))!
        setFavoriteImage()
    }

    @IBAction func favoriteAction(_ sender: UIButton) {
       isFavorite = !isFavorite
       dogEntry?.setFavorite(isFavorite: isFavorite, userEmail: (userPreference.user?.email)!)
       setFavoriteImage()
    }
    
    func setFavoriteImage() {
        favoriteButton.setImage(UIImage(named: (isFavorite ? "favorite_fill" : "favorite_unfill")), for: .normal)
    }
}








