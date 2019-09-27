//
//  FriendsTableViewController.swift
//  HobbyTracker
//
//  Created by Christian Lorenzo on 9/19/19.
//  Copyright © 2019 Christian Lorenzo. All rights reserved.
//

import UIKit

class FriendsTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var friends: [Friend] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddFriendModelSegue" {
            guard let addFriendVC = segue.destination as? AddFriendViewController else {fatalError()}
            
            addFriendVC.delegate = self
        }
    }
}

//MARK: - Table View Data Source
//Adding an extension for the UITableViewDatSource

extension FriendsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Asking for the cell to show and use.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendTableViewCell else {
            fatalError()
        }
        
        let friend = friends[indexPath.row] // Getting a friend from the list of friends. Associating from the array Friend to the cell friend below.
        
        cell.friend = friend //Assigning friend to the cell.
        
        //Use cell here
        return cell
        
    }
    
    
}


//MARK: - Add Friend Delegate

extension FriendsTableViewController: addFriendDelegate {
    func friendWasCreated(_ friend: Friend) {
        friends.append(friend)
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        //TODO: Implement delegate method here!
    }
}
