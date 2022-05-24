//
//  ProjectItem.swift
//  Tickets
//
//  Created by Timmy Nguyen on 5/19/22.
//

import SwiftUI

struct ProjectItem: View {
    let data: Project
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "clock")
                .foregroundColor(.secondary)
            VStack(alignment: .leading) {
                HStack {
                    Text(data.type)
                        .foregroundColor(.teal)
                    Spacer()
                    Text(data.dueDate)
                        .foregroundColor(.orange)
                }
                .padding(.bottom, 4)
                .font(.subheadline)
                
                Text(data.title)
                    .padding(.bottom, 4)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Label("4 Attendees", systemImage: "person.3.fill")
                    Spacer()
                    Label("8", systemImage: "ticket")
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
        ProjectItem(data: Project.sampleData[1])
            .previewLayout(.sizeThatFits)
    }
}
