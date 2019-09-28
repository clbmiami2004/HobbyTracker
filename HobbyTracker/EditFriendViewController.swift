//
//  AddFriendViewController.swift
//  HobbyTracker
//
//  Created by Christian Lorenzo on 9/25/19.
//  Copyright © 2019 Christian Lorenzo. All rights reserved.
//

import UIKit

protocol addFriendDelegate { // This is to let our first view controller that a new friend has been added.
    func friendWasCreated(_ friend: Friend)
    func friend(_ oldFriend: Friend, wasUpdated newFriend: Friend)
}

class EditFriendViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField! //Make sure to name the field as the type in order to be able to read the code better.
    
    @IBOutlet weak var hometownTextField: UITextField!
    @IBOutlet weak var hobby1TextField: UITextField!
    @IBOutlet weak var hobby2TextField: UITextField!
    @IBOutlet weak var hobby3TextField: UITextField!
    
    //Adding a delegte property associated with the addFriendDelegate:
    var delegate: addFriendDelegate?
    
    var oldFriend: Friend?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
//MARK: - THis is how we update an old friend from the list, ej: chaging hobby or address.
    
    func updateViews() {
        guard let oldFriend = oldFriend else {
            return
        }
        
        nameTextField.text = oldFriend.name
        hometownTextField.text = oldFriend.hometown
        
        if oldFriend.hobbies.count > 0 {
            hobby1TextField.text = oldFriend.hobbies[0]
            
            if oldFriend.hobbies.count > 1 {
                hobby2TextField.text = oldFriend.hobbies[1]
                
                if oldFriend.hobbies.count > 2 {
                    hobby3TextField.text = oldFriend.hobbies[2]
                }
            }
        }
    }
    
    
 
    @IBAction func cancelOperation(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveFriend(_ sender: UIBarButtonItem) {
        
        guard let name = nameTextField.text, !name.isEmpty, //name not empty
            let hometown = hometownTextField.text, !hometown.isEmpty else {return}
        
        var friend = Friend(name: name, hometown: hometown)
        
        //Checking each of the individual hobby textFields to se if we can add that hobby to our list of friends.
        
        if let hobby1 = hobby1TextField.text, !hobby1.isEmpty {
            friend.hobbies.append(hobby1)
        }
        
        if let hobby2 = hobby2TextField.text, !hobby2.isEmpty {
            friend.hobbies.append(hobby2)
        }
        
        if let hobby3 = hobby3TextField.text, !hobby3.isEmpty {
            friend.hobbies.append(hobby3)
        }
            
//Here if we're not updating, then we're creating a new friend.
        if let oldFriend = oldFriend {
            
        }else {
        delegate?.friendWasCreated(friend)
        }
    }
    
    //FIXME: The keyboard doesn't go away automatically.

}

//MARK: - Text Field Delegate

//Adding the return key as a new line on the view controller.

extension EditFriendViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty {
            switch textField {
            case nameTextField:
                hometownTextField.becomeFirstResponder()
            case hometownTextField:
                hobby1TextField.becomeFirstResponder()
            case hobby1TextField:
                hobby2TextField.becomeFirstResponder()
            case hobby2TextField:
                hobby3TextField.becomeFirstResponder()
            default:
                textField.resignFirstResponder() //This will hide the keyboard.
            }
            
        }else {
            view.endEditing(false) //Stop editing and hide the keyboard.
        }
        return false
    }
}
