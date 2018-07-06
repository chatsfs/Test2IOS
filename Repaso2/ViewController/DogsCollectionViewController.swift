//
//  DogsCollectionViewController.swift
//  Repaso2
//
//  Created by Erick Carrasco on 7/5/18.
//  Copyright © 2018 Erick Carrasco. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage

private let reuseIdentifier = "Cell"

class DogCell: UICollectionViewCell {
    
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogIdLabel: UILabel!
    
    func updateView(from dog:DogEntity){
        dogIdLabel.text = dog.dogId
        if let url = URL(string: dog.dogImage){
            dogImageView.af_setImage(withURL: url)
        }
 
    }
    
}

class DogsCollectionViewController: UICollectionViewController {

    let dogStore = DogStore()
    var dogs: [DogEntity] = []
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dogs.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DogCell
    
        // Configure the cell
        cell.updateView(from: dogs[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAbout"{
            let aboutViewController = segue.destination as! AboutViewController
            aboutViewController.dogEntry = dogs[currentIndex]
        }
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currentIndex = indexPath.row
        self.performSegue(withIdentifier: "showAbout", sender: self)
    }
    
    func updateData(){
        Alamofire.request("https://api.thedogapi.co.uk/v2/dog.php?limit=50")
        .validate()
        .responseJSON(completionHandler: {
                response in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    let jsonData = json["data"].arrayValue
                    self.dogs = DogEntity.builAll(from: jsonData)
                    self.collectionView!.reloadData()
                case .failure(let error):
                    print("Error \(error.localizedDescription)")
                }
            })
        
    }

}
