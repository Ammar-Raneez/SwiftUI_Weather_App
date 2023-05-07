//
//  HomeView.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI
import CoreLocation

struct Home: View {
    
    @EnvironmentObject var weatherModelData: WeatherModelData
    @State var isSearchOpen: Bool = false
    @State var userLocation: String = ""
    
    var body: some View {
        ZStack {
            Image("background2")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.8)
            
            // Multiple Spacers are added in sections to replicate the mock wireframes as close possible
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        Spacer()
                        Picker(selection: $weatherModelData.unit, label: Text("Unit Picker")) {
                            Text(Unit.celsius.rawValue).tag(Unit.celsius)
                            Text(Unit.farenheit.rawValue).tag(Unit.farenheit)
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 100)
                    }
                    .padding(.horizontal)

                    Button {
                        self.isSearchOpen.toggle()
                    } label: {
                        Text("Change Location")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                    }
                    .sheet(isPresented: $isSearchOpen) {
                        SearchView(isSearchOpen: $isSearchOpen, userLocation: $userLocation)
                    }
                    .padding()
                    
                    Spacer()
                    Spacer()
                    
                    // The default gap is larger than the mock wireframes
                    VStack(spacing: 3) {
                        WeatherDetail(information: userLocation, font: .title)
                        WeatherDetail(information: Date(timeIntervalSince1970: TimeInterval(((Int)(weatherModelData.forecast?.current.dt ?? 0))))
                            .formatted(.dateTime.year().hour().month().day()), font: .largeTitle, shadowRadius: 1)
                    }
                    
                    Spacer()
                    Spacer()
                    
                    // The default gap is larger than the mock wireframes
                    VStack(spacing: 3) {
                        WeatherDetail(information: "Temp: \((Int)(weatherModelData.convertMetric(weatherModelData.forecast!.current.temp)))\(weatherModelData.unit.rawValue)")
                        WeatherDetail(information: "Humidity: \((Int)(weatherModelData.forecast!.current.humidity))%")
                        WeatherDetail(information: "Pressure: \((Int)(weatherModelData.forecast!.current.pressure)) hPa")
                    }
                    
                    HStack {
                        BufferingImage(imageUrl: "https://openweathermap.org/img/wn/\(weatherModelData.forecast!.current.weather[0].icon)@2x.png")
                        WeatherDetail(information: "\(weatherModelData.forecast!.current.weather[0].weatherDescription.rawValue)")
                    }
                }
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
            }
        }
    }
}

struct WeatherDetail: View {
    var information: String
    var font: Font = .title2
    var shadowRadius: Double = 0.5
    
    var body: some View {
        Text("\(information)")
            .padding()
            .font(font)
            .foregroundColor(.black)
            .shadow(color: .black, radius: shadowRadius)
            .multilineTextAlignment(.center)
    }
}
