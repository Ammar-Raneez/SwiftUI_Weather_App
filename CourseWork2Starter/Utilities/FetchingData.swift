//
//  FetchingData.swift
//  CourseWork2Starter
//
//  Created by Ammar on 2023-05-08.
//

import SwiftUI

struct FetchingData: View {
    var information: String
    
    var body: some View {
        ProgressView(information)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(.systemBackground))
            )
            .shadow(radius: 5)
    }
}

struct FetchingData_Previews: PreviewProvider {
    static var previews: some View {
        FetchingData(information: "Fetching Weather")
    }
}
