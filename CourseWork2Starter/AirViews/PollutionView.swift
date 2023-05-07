//
//  PollutionView.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct PollutionView: View {
    
    @EnvironmentObject var weatherModelData: WeatherModelData
    @EnvironmentObject var airModelData: AirModelData
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.5)
            
            ScrollView {
                VStack(spacing: 20) {
                    LocationHeader(userLocation: weatherModelData.userLocation)
                    
                    VStack {
                        Text("\((Int)(weatherModelData.convertMetric(weatherModelData.forecast!.current.temp)))\(weatherModelData.unit.rawValue)")
                            .padding()
                            .font(.largeTitle)
                        
                        HStack {
                            BufferingImage(imageUrl: "https://openweathermap.org/img/wn/\(weatherModelData.forecast!.current.weather[0].icon)@2x.png")        
                            Text(weatherModelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                        .padding()
                        
                        Text("Feels Like: \((Int)(weatherModelData.convertMetric(weatherModelData.forecast!.current.feelsLike)))\(weatherModelData.unit.rawValue)")
                            .foregroundColor(.black)
                    }
                    .padding()
                    
                    Text("Air Quality Data")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    HStack {
                        PollutionDetail(
                            imageName: "so2",
                            information: "\(String(format: "%.2f", (airModelData.pollution?.list[0].components.so2 ?? 0)))"
                        )
                        
                        PollutionDetail(
                            imageName: "no",
                            information: "\(String(format: "%.2f", (airModelData.pollution?.list[0].components.no ?? 0)))"
                        )
                        
                        PollutionDetail(
                            imageName: "voc",
                            information: "\(String(format: "%.2f", (airModelData.pollution?.list[0].components.co ?? 0)))"
                        )

                        PollutionDetail(
                            imageName: "pm",
                            information: "\(String(format: "%.2f", (airModelData.pollution?.list[0].components.pm10 ?? 0)))"
                        )
                    }
                    .padding(.horizontal)
                }
                .onAppear {
                    Task.init {
                        try await self.airModelData.loadAirPollution(lat: weatherModelData.forecast!.lat, lon: weatherModelData.forecast!.lon)
                    }
                }
                .foregroundColor(.black)
                .shadow(color: .black,  radius: 0.5)
            }
        }
    }
}

struct PollutionDetail: View {
    var imageName: String
    var information: String
    
    var body: some View {
        VStack {
            Image(imageName).resizable().scaledToFit()
            Text(information)
                .padding(.top, 20)
        }
        .padding(10)
        
        Spacer()
    }
}
