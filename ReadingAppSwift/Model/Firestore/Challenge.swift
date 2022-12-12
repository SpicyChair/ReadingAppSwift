//
//  Challenge.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 30/11/2022.
//

import Foundation

struct Challenge : Hashable {
    
    var title: String
    var description: String
    // variable of user's UID - only the user who has created the challenge
    // can edit the challenge
    var createdBy: String
    
    // the challenge's UID to identify each challenge
    var uid: String
    
    var users: [String]
}
