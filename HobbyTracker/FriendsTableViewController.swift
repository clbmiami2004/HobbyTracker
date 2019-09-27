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
        
        friends.append(Friend(name: "Person A", hometown: "Los Angeles", hobbies: ["A", "B"]))
        friends.append(Friend(name: "Person B", hometown: "San Diego", hobbies: ["A", "B"]))
        friends.append(Friend(name: "Person C", hometown: "New York", hobbies: ["A", "B", "C"]))
        friends.append(Friend(name: "Person D", hometown: "Seattle", hobbies: ["A", "B"]))
        friends.append(Friend(name: "Person E", hometown: "Tokio", hobbies: ["A", "B", "C"]))
    }

    

}

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
