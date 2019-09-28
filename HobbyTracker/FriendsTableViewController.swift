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
    var indexPathforTappedAccessoryButton: IndexPath?
    
    
//MARK: - Returning the URL where we're going to save the document "Story of our friends".
    
    //By putting the exclamation mark we're saying that this will never be nil.
    var persistentStoreURL: URL! {
        
        if let documentURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) {
            let persistentStoreURL = documentURL.appendingPathComponent("friendsList.plist")
            
            return persistentStoreURL
        }
        
        return nil

    }

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Now we load from the file in order to save from the file.
        
        if let data = try? Data(contentsOf: persistentStoreURL),
            let savedFriends = try? PropertyListDecoder().decode([Friend].self, from: data) {
            
            friends = savedFriends
        }
        
    }

    
//MARK: - Saving Friends.
    func save() {
        if let data = try? PropertyListEncoder().encode(friends) {
            try? data.write(to: persistentStoreURL)
        }
    }

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "AddFriendModelSegue":
            guard let addFriendVC = segue.destination as? EditFriendViewController else {fatalError()}
            
            addFriendVC.delegate = self
        case "UpdateFriendModelSegue":
            guard let indexPath = indexPathforTappedAccessoryButton,
                let editFriendVC = segue.destination as?
                EditFriendViewController else {
                fatalError()}
            
            //It'll let us know when the user is finished editing.
            editFriendVC.delegate = self
            //Us telling it what the old friend was that it needs to be editing.
            editFriendVC.oldFriend = friends[indexPath.row]
            
        case "ShowFriendDetailSegue":
            guard let indexPath = tableView.indexPathForSelectedRow, let friendDetailVC = segue.destination as? FriendDetailViewController else {fatalError()}
            
            friendDetailVC.friend = friends[indexPath.row]
            
        default:
            fatalError("An unknown segue was encountered: \(segue.identifier ?? "<No ID>")")
            //We're printing the segue idientifier, and if there's no identifier, then print "No ID."
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

//MARK: - Table View Delegate. Code for deleleting friends.

extension FriendsTableViewController: UITableViewDelegate  {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        friends.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        save()
    }
    
    //This is going to be called anytime the iButton is tapped and it's going to let us knnow which row was tapped.
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        indexPathforTappedAccessoryButton = indexPath
        
        performSegue(withIdentifier: "UpdateFriendModelSegue", sender: self)
        
        
    }
}

//MARK: - Add Friend Delegate

extension FriendsTableViewController: addFriendDelegate {
    func friendWasCreated(_ friend: Friend) {
        friends.append(friend)
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        //TODO: Implement delegate method here!
        
        save()
    }
    
    func friend(_ oldFriend: Friend, wasUpdated newFriend: Friend) {
        guard let indexPath = indexPathforTappedAccessoryButton else {return}
        friends[indexPath.row] = newFriend
        tableView.reloadRows(at: [indexPath], with: .automatic)
        dismiss(animated: true, completion: nil)
        
        save()
    }
    
}
