//
//  FavoriteTableViewController.swift
//  Repaso2
//
//  Created by Erick Carrasco on 7/5/18.
//  Copyright © 2018 Erick Carrasco. All rights reserved.
//

import UIKit
import AlamofireImage

private let reuseIdentifier = "Table"

class TableCell: UITableViewCell {
    
    @IBOutlet weak var dogIdLabel: UILabel!
    @IBOutlet weak var dogImageView: UIImageView!
    
    func upateView(for dog: DogEntity){
        dogIdLabel.text = dog.dogId
        if let url = URL(string: dog.dogImage){
            dogImageView.af_setImage(withURL: url)
        }
    }
}

class FavoriteTableViewController: UITableViewController {

    let favoriteStore = DogStore()
    var favorites: [DogEntity] = []
    var currentIndex: Int = 0
    let userPreference = UserPreference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        update()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favorites.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TableCell
        
        // Configure the cell...
        cell.upateView(for: favorites[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAbout" {
            let aboutViewController = segue.destination as! AboutViewController
            aboutViewController.dogEntry = favorites[currentIndex]
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        self.performSegue(withIdentifier: "showAbout", sender: self)
    }
    
    func update(){
        favorites = favoriteStore.findDogsByUserEmail((userPreference.user?.email)!)!        
        self.tableView!.reloadData()
    }

}
