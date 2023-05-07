//
//  CurrentWeatherView.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct CurrentWeatherView: View {
    
    @EnvironmentObject var weatherModelData: WeatherModelData
    
    var body: some View {
        ZStack {
            Image("background2")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.8)
            
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
                    
                    VStack {
                        WeatherDetailRow(
                            colOneInformation: "Wind Speed: \((Int)(weatherModelData.forecast!.current.windSpeed)) m/s",
                            colTwoInformation: "Direction: \(convertDegToCardinal(deg: weatherModelData.forecast!.current.windDeg))"
                        )
                        
                        WeatherDetailRow(
                            colOneInformation: "Humidity: \((Int)(weatherModelData.forecast!.current.humidity))%",
                            colTwoInformation: "Pressure: \((Int)(weatherModelData.forecast!.current.pressure)) hPa",
                            topPadding: 40
                        )
                        
                        HStack {
                            Label(Date(timeIntervalSince1970: TimeInterval(((Int)(weatherModelData.forecast?.current.sunset ?? 0))))
                                .formatted(.dateTime.hour().minute()), systemImage: "sunset.fill")
                            .symbolRenderingMode(.multicolor)
                            .font(.title3)
                            .padding()
                            
                            Label(Date(timeIntervalSince1970: TimeInterval(((Int)(weatherModelData.forecast?.current.sunrise ?? 0))))
                                .formatted(.dateTime.hour().minute()), systemImage: "sunrise.fill")
                            .symbolRenderingMode(.multicolor)
                            .font(.title3)
                            .padding()
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .foregroundColor(.black)
                .shadow(color: .black,  radius: 0.5)
            }
        }
    }
}

struct WeatherDetailRow: View {
    var colOneInformation: String
    var colTwoInformation: String
    var topPadding: Double = 10
    
    var body: some View {
        HStack {
            Text(colOneInformation)
                .font(.title3)
            
            Spacer()
            
            Text(colTwoInformation)
                .font(.title3)
        }
        .padding(.horizontal, 20)
        .padding(.top, topPadding)
    }
}

struct Conditions_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
            .environmentObject(WeatherModelData())
    }
}
