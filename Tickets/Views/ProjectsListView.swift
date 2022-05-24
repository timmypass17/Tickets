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
                let _ = print(projectStore.projects.count)
                ForEach(projectStore.projects) { project in
                    NavigationLink {
                        ProjectDetail(data: project)
                    } label: {
                        ProjectItem(data: project)
                    }
                }
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isPresentingNewProjectView = true}
                ) {
                    Image(systemName: "plus")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .navigationTitle("My Projects")
        .sheet(isPresented: $isPresentingNewProjectView) {
            NavigationView {
                EditProjectView(data: $newProject)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewProjectView = false
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
                                }
                            }
                        }
                    }
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
