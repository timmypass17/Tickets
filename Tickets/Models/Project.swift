//
//  Project.swift
//  Tickets
//
//  Created by Timmy Nguyen on 5/17/22.
//

import Foundation

// Conforms to Identifiable to be able to use in a list
struct Project: Identifiable, Codable {
    let id: UUID
    var projectID: String
    var title: String
    var description: String
    var type: String
    var dueDate: String
    var attendees: [String: String] /// username: id
    var tickets: [Ticket]

    init(id: UUID = UUID(), projectID: String = "", title: String = "", description: String = "", type: String = "", dueDate: String = "",
         attendees: [String: String] = [:], tickets: [Ticket] = []) {
        self.id = id
        self.projectID = projectID
        self.title = title
        self.description = description
        self.type = type
        self.dueDate = dueDate
        self.attendees = attendees
        self.tickets = tickets
    }
    
}

extension Project {
    static let sampleUser = User(uid: "123", name: "Hamtaro", email: "hamtaro123@gmail.com", username: "hamtaro20", projects: [])
    static let sampleData: [Project] =
    [
        Project(title: "[Mobile] Create iOS Product List", description: "", type:"iOS Development", dueDate: "28 dec", attendees: [sampleUser.username: sampleUser.id.uuidString]),
        Project(title: "Monitor system performance and adjust hardware as required", description: "Project description...", type:"iOS Development", dueDate: "20 oct")
    ]
}
