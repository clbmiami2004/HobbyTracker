//
//  FriendDetailViewController.swift
//  HobbyTracker
//
//  Created by Christian Lorenzo on 9/25/19.
//  Copyright © 2019 Christian Lorenzo. All rights reserved.
//

import UIKit

class FriendDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var hometownLabel: UILabel!
    
    @IBOutlet weak var hobbyListTextView: UITextView!
    
    var friend: Friend? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    private func updateViews() {
        guard let friend = friend, isViewLoaded else {return}
        
        nameLabel.text = friend.name
        hometownLabel.text = friend.hometown
        
        
        //Variables to hold the text.
        //Formatting ech of the hobbies and format them in to the print statement below.
        var hobbyText = ""
        for hobby in friend.hobbies {
            hobbyText += "• \(hobby)\n"
        }
        
        hobbyListTextView.text = hobbyText
        
    }

}
