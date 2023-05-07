//
//  AirQualityRow.swift
//  CourseWork2Starter
//
//  Created by Ammar on 2023-05-08.
//

import SwiftUI

struct AirQualityRow: View {
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(logo)
                .font(.title2)
                .frame(width: 20, height: 20)
                .padding()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.caption)
                
                Text(value)
                    .bold()
                    .font(.title)
            }
        }
    }
}

struct AirQualityRow_Previews: PreviewProvider {
    static var previews: some View {
        AirQualityRow(logo: "no", name: "Nitrogen Oxide", value: "15")
    }
}
