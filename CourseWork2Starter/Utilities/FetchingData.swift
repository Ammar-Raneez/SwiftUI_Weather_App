//
//  Loader.swift
//  CourseWork2
//  Loading spinner-fetching data
//  Created by Ammar on 2023-05-08.
//

import SwiftUI

struct Loader: View {
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

struct Loader_Previews: PreviewProvider {
    static var previews: some View {
        Loader(information: "Fetching Weather")
    }
}
