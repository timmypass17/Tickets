//
//  ProfileHeader.swift
//  Tickets
//
//  Created by Timmy Nguyen on 5/18/22.
//

import SwiftUI

struct ProfileHeader: View {
    @EnvironmentObject var projectStore: ProjectStore

    var body: some View {
        HStack {
            Image("hamtaro")
                .resizable()
                .frame(width: 64, height: 64)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 2)
                }
                .shadow(radius: 3)
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(projectStore.currentUser.name)
                    Text("@hamtaro20")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 14, height: 14)
                    Text("online")
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct ProfileHeader_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeader()
            .environmentObject(ProjectStore())
            .previewLayout(.sizeThatFits)
    }
}
