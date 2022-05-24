//
//  CreateProjectView.swift
//  Tickets
//
//  Created by Timmy Nguyen on 5/19/22.
//

import SwiftUI

struct EditProjectView: View {
    @Binding var data: Project
    @State private var newAttendeeName: String = ""
    var body: some View {
        Form {
            Section(header: Text("Project Info")) {
                TextField("Project Name", text: $data.title)
                TextField("Type", text: $data.type)
                TextField("Due Date", text: $data.dueDate)
                TextField("Description", text: $data.description)
            }
            Section(header: Text("Attendees")) {
                ForEach(data.attendees.sorted(by: >), id: \.key) { name, _ in
                    Text(name)
                }
                .onDelete { indices in
                    // TODO: Remove person from firebase
                }
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {
                        withAnimation {
                            let attendee = User(uid: "123", name: newAttendeeName, email: "timmy123@gmail.com", username: "timmy123", projects: [])
//                            data.attendees.append()
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
        .navigationTitle("Add Project")
        
    }
}

struct EditProjectView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditProjectView(data: .constant(Project.sampleData[0]))
        }
    }
}
