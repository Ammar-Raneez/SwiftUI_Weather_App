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
                .opacity(0.6)
            
            ScrollView {
                VStack {
                    VStack {
                        LocationHeader(weatherModelData: weatherModelData)
                        
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
                        TimeRow(logo: "thermometer", name: "Min temp", value: "\((Int)(weatherModelData.convertMetric(weatherModelData.forecast!.daily[0].temp.min)))\(weatherModelData.unit.rawValue)")
                            .padding()
                        TimeRow(logo: "thermometer", name: "Max temp", value: "\((Int)(weatherModelData.convertMetric(weatherModelData.forecast!.daily[0].temp.max)))\(weatherModelData.unit.rawValue)")
                            .padding()
                    }
                    
                    HStack {
                        TimeRow(logo: "sunset.fill", name: "Sunset", value: "\(Date(timeIntervalSince1970: TimeInterval(((Int)(weatherModelData.forecast?.current.sunset ?? 0)))).formatted(.dateTime.hour().minute()))")
                            .padding()
                        TimeRow(logo: "sunrise.fill", name: "Sunrise", value: "\(Date(timeIntervalSince1970: TimeInterval(((Int)(weatherModelData.forecast?.current.sunrise ?? 0)))).formatted(.dateTime.hour().minute()))")
                            .padding()
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Weather now")
                            .bold()
                            .padding(.bottom)
                        
                        HStack {
                            WeatherRow(logo: "wind", name: "Wind Speed", value: "\((Int)(weatherModelData.forecast!.current.windSpeed)) m/s")
                            Spacer()
                            WeatherRow(logo: "wind", name: "Direction", value: "\(convertDegToCardinal(deg: weatherModelData.forecast!.current.windDeg))")
                        }
                        
                        HStack {
                            WeatherRow(logo: "tornado", name: "Pressure", value: "\((Int)(weatherModelData.forecast!.current.pressure)) hPa")
                            Spacer()
                            WeatherRow(logo: "humidity", name: "Humidity", value: "\((Int)(weatherModelData.forecast!.current.humidity))%")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.bottom, 20)
                    .background(.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                }
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

struct Conditions_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
            .environmentObject(WeatherModelData())
    }
}
