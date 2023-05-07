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
                .opacity(0.6)
            
            VStack {
                VStack {
                    LocationHeader(weatherModelData: weatherModelData)
                    
                    VStack {
                        // Use a scrollview instead of a list for the customized display
                        ScrollView {
                            ForEach(weatherModelData.forecast!.daily) { day in
                                DailyView(day: day)
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
                    FetchingData(information: "Fetching Weather Data")
                }
            }
        }
    }
}

struct Forecast_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView().environmentObject(WeatherModelData())
    }
}
