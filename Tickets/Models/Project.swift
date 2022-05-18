//
//  Project.swift
//  Tickets
//
//  Created by Timmy Nguyen on 5/17/22.
//

import Foundation

struct Project {
    var title: String
    var type: String
}

#if DEBUG
let testDataProjects = [
    Project(title: "[Mobile] Create iOS Product List", type: "iOS Development"),
    Project(title: "Monitor system performance and adjust hardware as required", type: "iOS Development"),
    Project(title: "[Mobile] Connect to Firebase", type: "iOS Development"),
]
#endif
