//
//  CreateProjectView.swift
//  Tickets
//
//  Created by Timmy Nguyen on 5/19/22.
//

import SwiftUI

struct EditProjectView: View {
    @EnvironmentObject var projectStore: ProjectStore
    @Binding var currentProject: Project
    @State private var newAttendeeName: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Project Info")) {
                TextField("Project Name", text: $currentProject.title)
                TextField("Type", text: $currentProject.type)
                TextField("Due Date", text: $currentProject.dueDate)
                TextField("Description", text: $currentProject.description)
            }
            Section(header: Text("Attendees")) {
                ForEach(currentProject.attendees.sorted(by: >), id: \.key) { userID, name in
                    Text(name)
                }
                .onDelete { indices in
                    // TODO: Remove person from firebase
                }
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {
                        withAnimation {
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
            Button("Delete Project", role: .destructive) {
                projectStore.deleteProject(project: currentProject)
            }
        }
    }
}

struct EditProjectView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditProjectView(currentProject: .constant(Project.sampleData[0]))
        }
    }
}
