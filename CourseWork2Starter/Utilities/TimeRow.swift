//
//  TimeRow.swift
//  CourseWork2
//  Time (sunset/sunrise) detail field
//  Created by Ammar on 2023-05-08.
//

import SwiftUI

struct TimeRow: View {
    var logo: String
    var name: String
    var value: String
    var iconRenderingModel: SymbolRenderingMode = .multicolor

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: logo)
                .font(.title2)
                .symbolRenderingMode(iconRenderingModel)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.caption)
                Text(value)
                    .fontWeight(.semibold)
                    .font(.title2)
            }
        }
    }
}

struct TimeRow_Previews: PreviewProvider {
    static var previews: some View {
        TimeRow(logo: "sunset.fill", name: "Feels like", value: "10:30 PM")
    }
}
