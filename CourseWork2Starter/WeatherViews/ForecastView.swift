//
//  ForecastView.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct ForecastView: View {

    @EnvironmentObject var weatherModelData: WeatherModelData

     var body: some View {
         ZStack {
             Image("background2")
                 .resizable()
                 .ignoresSafeArea()
             
             VStack {
                 Text("\(weatherModelData.userLocation)")
                     .font(.largeTitle)
                     .shadow(color: .black, radius: 0.5)
                 
                 List {
                     ForEach(weatherModelData.forecast!.daily) { day in
                         DailyView(day: day)
                     }
                 }
             }
             .opacity(0.8)
         }
     }
}

struct Forecast_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView().environmentObject(WeatherModelData())
    }
}
