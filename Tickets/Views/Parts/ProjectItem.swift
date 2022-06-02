//
//  ProjectItem.swift
//  Tickets
//
//  Created by Timmy Nguyen on 5/19/22.
//

import SwiftUI

struct ProjectItem: View {
    let project: Project
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "clock")
                .foregroundColor(.secondary)
            VStack(alignment: .leading) {
                HStack {
                    Text(project.type)
                        .foregroundColor(.teal)
                    Spacer()
                    Text(project.dueDate)
                        .foregroundColor(.orange)
                }
                .padding(.bottom, 4)
                .font(.subheadline)
                
                Text(project.title)
                    .padding(.bottom, 4)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Label("\(project.attendees.count) Attendees", systemImage: "person.3.fill")
                    Spacer()
                    Label("\(project.tickets.count)", systemImage: "ticket")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray)
        )
        .padding([.leading, .trailing, .top], 15)
    }
}

struct ProjectItem_Previews: PreviewProvider {
    static var previews: some View {
        ProjectItem(project: Project.sampleData[1])
            .previewLayout(.sizeThatFits)
    }
}
