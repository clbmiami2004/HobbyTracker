//
//  Friend.swift
//  HobbyTracker
//
//  Created by Christian Lorenzo on 9/25/19.
//  Copyright © 2019 Christian Lorenzo. All rights reserved.
//

import Foundation

struct Friend: Codable {  //Codable in order To make the app able to save information within. Images not allowed with this method.
    let name: String
    let hometown: String
    var hobbies: [String] = []
}
