//
//  PollutionView.swift
//  Coursework2
//  Pollution screen - displays the pollution and air quality rate for a particular location
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
                .opacity(0.3)
            
            ScrollView {
                VStack {
                    VStack {
                        LocationHeader()
                        
                        HStack {
                            BufferingImage(imageUrl: "https://openweathermap.org/img/wn/\(weatherModelData.forecast!.current.weather[0].icon)@2x.png")
                            Text("\(weatherModelData.forecast!.current.weather[0].weatherDescription.rawValue)")
                        }
                        
                        Spacer()
                        
                        Text("\((Int)(weatherModelData.convertMetric(weatherModelData.forecast!.current.temp)))\(weatherModelData.unit.rawValue)")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .padding()
                        
                        Text("Feels like: \((Int)(weatherModelData.convertMetric(weatherModelData.forecast!.current.feelsLike)))\(weatherModelData.unit.rawValue)")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .padding()
                        
                        Picker(selection: $weatherModelData.unit, label: Text("Unit Picker")) {
                            Text(Unit.celsius.rawValue).tag(Unit.celsius)
                            Text(Unit.farenheit.rawValue).tag(Unit.farenheit)
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 100)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    HStack {
                        TimeRow(logo: "thermometer.low", name: "Min temp", value: "\((Int)(weatherModelData.convertMetric(weatherModelData.forecast!.daily[0].temp.min)))\(weatherModelData.unit.rawValue)", iconRenderingModel: .monochrome)
                            .padding()
                        TimeRow(logo: "thermometer.high", name: "Max temp", value: "\((Int)(weatherModelData.convertMetric(weatherModelData.forecast!.daily[0].temp.max)))\(weatherModelData.unit.rawValue)", iconRenderingModel: .monochrome)
                            .padding()
                    }
                    
                    VStack {
                        Spacer()
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Air Quality Data")
                                .bold()
                                .padding(.bottom)
                            
                            HStack {
                                AirQualityRow(logo: "so2", name: "SO2", value: "\(String(format: "%.2f", (airModelData.pollution?.list[0].components.so2 ?? 0)))")
                                Spacer()
                                AirQualityRow(logo: "no", name: "NO", value: "\(String(format: "%.2f", (airModelData.pollution?.list[0].components.no ?? 0)))")
                            }
                            .padding()
                            
                            HStack {
                                AirQualityRow(logo: "voc", name: "CO", value: "\(String(format: "%.2f", (airModelData.pollution?.list[0].components.co ?? 0)))")
                                Spacer()
                                AirQualityRow(logo: "pm", name: "PM10", value: "\(String(format: "%.2f", (airModelData.pollution?.list[0].components.pm10 ?? 0)))")
                            }
                            .padding()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .padding(.bottom, 20)
                        .background(.white)
                        .cornerRadius(20, corners: [.topLeft, .topRight])
                    }
                }
            }
            .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
            .onAppear {
                Task.init {
                    try await self.airModelData.loadAirPollution(lat: weatherModelData.forecast!.lat, lon: weatherModelData.forecast!.lon)
                }
            }
            if airModelData.isPollutionLoading {
                ZStack {
                    Color(.white)
                        .opacity(0.3)
                        .ignoresSafeArea()
                    Loader(information: "Fetching Air Pollution Data")
                }
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
