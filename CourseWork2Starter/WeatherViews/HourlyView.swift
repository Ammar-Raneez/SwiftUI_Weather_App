//
//  HourlyView.swift
//  Coursework2
//  Hourly screen - to view hourly forecasts
//  Created by G Lukka.
//

import SwiftUI

struct HourlyView: View {
    
    @EnvironmentObject var weatherModelData: WeatherModelData
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.3)
            
            VStack {
                VStack {
                    LocationHeader()
      
                    VStack {
                        // Use a scrollview instead of a list for the customized display
                        ScrollView {
                            ForEach(weatherModelData.forecast!.hourly) { hour in
                                HourlyForecast(current: hour)
                            }
                        }
                    }
                }
                .padding()
            }
            .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
            
            if weatherModelData.isWeatherLoading {
                ZStack {
                    Color(.white)
                        .opacity(0.3)
                        .ignoresSafeArea()
                    Loader(information: "Fetching Weather Data")
                }
            }
        }
    }
}

struct Hourly_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView().environmentObject(WeatherModelData())
    }
}
