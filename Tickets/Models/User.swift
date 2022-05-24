//
//  User.swift
//  Tickets
//
//  Created by Timmy Nguyen on 5/18/22.
//

import Foundation

/// Codable: For using firebase
struct User: Identifiable, Codable {
    let id: UUID    // for identifiiable
    var uid: String
    var name: String
    var email: String
    var username: String
    var projects: [String] // list of project's id
    
    init(id: UUID = UUID(), uid: String = "", name: String = "", email: String = "", username: String = "", projects: [String] = []) {
        self.id = id
        self.uid = uid
        self.name = name
        self.email = email
        self.username = username
        self.projects = projects
    }
    
    
}
