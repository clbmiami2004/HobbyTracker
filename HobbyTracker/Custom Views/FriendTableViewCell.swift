//
//  FriendTableViewCell.swift
//  HobbyTracker
//
//  Created by Christian Lorenzo on 9/25/19.
//  Copyright © 2019 Christian Lorenzo. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    //We want to create oujtlets for the tableViewCell in order to be able to access the name, hometown, and # of hobbies.
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var hometownLabel: UILabel!
    
    
    @IBOutlet weak var hobbyCountLabel: UILabel!
    
    
    //This is going to be called anytime that the friend property changes.
    var friend: Friend? {
        didSet {
            updateView()
        }
    }

    
    
    private func updateView() {
        //If this is called and there's no friend, then nothing is going to happen because it's unwrapped.
        guard let friend = friend else {return}
        
        
        //Assigning the name, hometown, and # of hobbies from the model to the outlet.
        nameLabel.text = friend.name
        hometownLabel.text = friend.hometown
        hobbyCountLabel.text = "\(friend.hobbies.count) hobbies"
        
        
    }

}
