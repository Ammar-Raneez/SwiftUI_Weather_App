//
//  HourCondition.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct HourCondition: View {
    
    @EnvironmentObject var weatherModelData: WeatherModelData

    var current : Current
    
    var body: some View {
        HStack {
            Spacer()

            VStack(alignment: .leading) {
                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(current.dt))))
                    .formatted(.dateTime.hour()))
                    .fontWeight(.semibold)

                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(current.dt))))
                    .formatted(.dateTime.weekday()))
                    .fontWeight(.semibold)
            }
            
            Spacer()

            BufferingImage(imageUrl: "https://openweathermap.org/img/wn/\(current.weather[0].icon)@2x.png")
            
            Spacer()
                    
            HStack {
                Text("\((Int)(weatherModelData.convertMetric(current.temp)))\(weatherModelData.unit.rawValue)")
                Text("\(current.weather[0].weatherDescription.rawValue.capitalized)")
            }
            
            Spacer()
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354).opacity(0.1))
        .cornerRadius(12)
        .padding(.vertical, 5)
    }
}

struct HourCondition_Previews: PreviewProvider {
    static var hourly = WeatherModelData().forecast!.hourly
    
    static var previews: some View {
        HourCondition(current: hourly[0])
    }
}
