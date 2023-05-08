//
//  HomeView.swift
//  Coursework2
//  Home screen - gives an overview of the weather of a particular location
//  Created by G Lukka.
//

import SwiftUI
import CoreLocation

struct HomeView: View {
    
    @EnvironmentObject var weatherModelData: WeatherModelData
    @State var isSearchOpen = false
    @State var userLocation = ""
    
    var body: some View {
        ZStack {
            Image("background2")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.6)
            
            VStack {
                VStack {
                    LocationHeader()
                    
                    HStack {
                        BufferingImage(imageUrl: "https://openweathermap.org/img/wn/\(weatherModelData.forecast!.current.weather[0].icon)@2x.png")
                        Text("\(weatherModelData.forecast!.current.weather[0].weatherDescription.rawValue)")
                    }
                                        
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
                        Text(Unit.fahrenheit.rawValue).tag(Unit.fahrenheit)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 100)
                    
                    Spacer()
                    
                    Button {
                        self.isSearchOpen.toggle()
                    } label: {
                        Text("Change Location")
                            .font(.title2)
                            .frame(width: 200, height: 42)
                    }
                    .buttonStyle(.bordered)
                    .tint(.indigo)
                    .buttonBorderShape(.roundedRectangle(radius: 12))
                    .sheet(isPresented: $isSearchOpen) {
                        SearchView(isSearchOpen: $isSearchOpen, userLocation: $userLocation)
                    }
                    .padding(.top, 24)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        WeatherRow(logo: "thermometer.low", name: "Min temp", value: "\((Int)(weatherModelData.convertMetric(weatherModelData.forecast!.daily[0].temp.min)))\(weatherModelData.unit.rawValue)")
                        Spacer()
                        WeatherRow(logo: "thermometer.high", name: "Max temp", value: "\((Int)(weatherModelData.convertMetric(weatherModelData.forecast!.daily[0].temp.max)))\(weatherModelData.unit.rawValue)")
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
            .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
            .onAppear {
                Task.init {
                    self.userLocation = await getLocFromLatLong(
                        lat: weatherModelData.forecast!.lat,
                        lon: weatherModelData.forecast!.lon
                    )
                    
                    self.weatherModelData.userLocation = self.userLocation
                }
            }
            .alert(item: $weatherModelData.alertItem) { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
            }
            
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
