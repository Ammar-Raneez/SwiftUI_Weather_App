//
//  LocationHeader.swift
//  CourseWork2Starter
//
//  Created by Ammar on 2023-05-01.
//

import SwiftUI

struct LocationHeader: View {
    var userLocation: String
    
    var body: some View {
        Spacer()
        
        Text(userLocation)
            .font(.largeTitle)
            .shadow(color: .black, radius: 0.5)
            .multilineTextAlignment(.center)
            .padding(.top)
    }
}

struct LocationHeader_Previews: PreviewProvider {
    static var previews: some View {
        LocationHeader(userLocation: "San Francisco")
    }
}
