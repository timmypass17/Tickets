//
//  ProjectDetail.swift
//  Tickets
//
//  Created by Timmy Nguyen on 5/19/22.
//

import SwiftUI

struct ProjectDetail: View {
    let data: Project
    var body: some View {
        Text("ProjectDetail")
    }

}

struct ProjectDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProjectDetail(data: Project.sampleData[0])
        }
    }
}
