//
//  ProjectDetail.swift
//  Tickets
//
//  Created by Timmy Nguyen on 5/19/22.
//

import SwiftUI
import FirebaseFirestore

struct ProjectDetail: View {
    @EnvironmentObject var projectStore: ProjectStore
    @Binding var currentProject: Project
    @State private var isPresentingEditProjectView = false

    var body: some View {
        VStack {
            Text("ProjectDetail")
        }
        .navigationTitle(currentProject.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isPresentingEditProjectView = true
                    
                }) {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $isPresentingEditProjectView) {
            NavigationView {
                EditProjectView(currentProject: $currentProject)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingEditProjectView = false
                                
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Confirm") {
                                projectStore.updateProject(id: currentProject.projectID, newProject: currentProject)
                                isPresentingEditProjectView = false
                            }
                        }
                    }
                    .navigationTitle("Edit Project")
            }
        }
    }

}

struct ProjectDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProjectDetail(currentProject: .constant(Project.sampleData[0]))
        }
    }
}
