//
//  DailyView.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct DailyView: View {
    
    @EnvironmentObject var weatherModelData: WeatherModelData

    var day : Daily
   
    var body: some View {
        HStack {
            BufferingImage(imageUrl: "https://openweathermap.org/img/wn/\(day.weather[0].icon)@2x.png")

            Spacer()
            
            VStack(alignment: .leading) {
                Text("\(day.weather[0].weatherDescription.rawValue)")
                    .fontWeight(.semibold)

                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(day.dt))))
                    .formatted(.dateTime.weekday(.wide).day()))
                    .fontWeight(.semibold)
            }
            
            Spacer()

            Text("\((Int)(weatherModelData.convertMetric(day.temp.max)))\(weatherModelData.unit.rawValue) / \((Int)(weatherModelData.convertMetric(day.temp.min)))\(weatherModelData.unit.rawValue)")
            
            // Push the values towards the center
            Spacer()
        }
        .background(.white.opacity(0.3))
        .cornerRadius(12)
        .padding(.vertical, 5)
    }
}

struct DailyView_Previews: PreviewProvider {
    static var day = WeatherModelData().forecast!.daily
    
    static var previews: some View {
        DailyView(day: day[0])
    }
}
