//
//  LocationHeader.swift
//  CourseWork2Starter
//
//  Created by Ammar on 2023-05-01.
//

import SwiftUI

struct LocationHeader: View {

    var weatherModelData: WeatherModelData
    var userLocation: String = ""
    
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

struct LocationHeader_Previews: PreviewProvider {
    static var previews: some View {
        LocationHeader(weatherModelData: WeatherModelData())
    }
}
