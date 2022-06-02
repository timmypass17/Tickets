//
//  ProjectsListView.swift
//  Tickets
//
//  Created by Timmy Nguyen on 5/18/22.
//

import SwiftUI
import FirebaseFirestore

struct ProjectsListView: View {
    @EnvironmentObject var projectStore: ProjectStore
    @State private var newProject = Project()
    @State private var isPresentingNewProjectView = false

    var body: some View {
        ScrollView {
            VStack {
                ProfileHeader()
                Divider()
                ForEach($projectStore.projects) { $project in
                    NavigationLink {
                        ProjectDetail(currentProject: $project)
                    } label: {
                        ProjectItem(project: project)
                    }
                }
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // maybe put in onAppear()?
                    newProject.attendees[projectStore.currentUser.uid] = projectStore.currentUser.name // add author to attendee's list
                    isPresentingNewProjectView = true
                }) {
                    Image(systemName: "plus")
                }
            }
            // Move this to another page?
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .navigationTitle("My Projects")
        .sheet(isPresented: $isPresentingNewProjectView) {
            NavigationView {
                EditProjectView(currentProject: $newProject)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewProjectView = false
                                newProject = Project()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                // TODO: Add project to firebase here
                                Task {
                                    // generate random firebase id
                                    let db = Firestore.firestore()
                                    let randomDoc = db.collection("projects").document()
                                    newProject.projectID = randomDoc.documentID
                                    
                                    await projectStore.addProject(project: newProject)
                                    isPresentingNewProjectView = false
                                    newProject = Project()
                                }
                            }
                        }
                    }
                    .navigationTitle("New Project")
            }
        }
    }
}

struct ProjectsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProjectsListView()
                .environmentObject(ProjectStore())
        }
    }
}
