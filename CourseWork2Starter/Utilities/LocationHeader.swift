//
//  LocationHeader.swift
//  CourseWork2
//  Reusable component for the app header used for each screen
//  Created by Ammar on 2023-05-01.
//

import SwiftUI

struct LocationHeader: View {

    @EnvironmentObject var weatherModelData: WeatherModelData
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(weatherModelData.userLocation)
                    .bold()
                    .font(.title)
                
                Text("\(Date(timeIntervalSince1970: TimeInterval(((Int)(weatherModelData.forecast?.current.dt ?? 0)))).formatted(.dateTime.year().hour().month().day()))")
                    .fontWeight(.light)
            }
            
            Spacer()
            
            Image(systemName: weatherModelData.currentTimeOfDay == TimeOfDay.morning ? "sunrise.fill" : weatherModelData.currentTimeOfDay == TimeOfDay.afternoon ? "sun.max.fill" : "moon.stars.fill")
                .symbolRenderingMode(.multicolor)
                .resizable()
                .frame(width: 50, height: 50)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
