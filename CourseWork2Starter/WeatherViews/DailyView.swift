//
//  DailyView.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct DailyView: View {
    var day : Daily
   
    var body: some View {
        HStack {
            BufferingImage(imageUrl: "https://openweathermap.org/img/wn/\(day.weather[0].icon)@2x.png")

            Spacer()
            
            VStack {
                Text("\(day.weather[0].weatherDescription.rawValue)")
                    .fontWeight(.semibold)

                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(day.dt))))
                    .formatted(.dateTime.weekday(.wide).day()))
                    .fontWeight(.semibold)
            }
            
            Spacer()

            Text("\((Int)(day.temp.max))ºC / \((Int)(day.temp.min))ºC")
        }.padding()
    }
    
}

struct DailyView_Previews: PreviewProvider {
    static var day = WeatherModelData().forecast!.daily
    
    static var previews: some View {
        DailyView(day: day[0])
    }
}
