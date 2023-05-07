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
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(userLocation)
                                .bold()
                                .font(.title)
                            
                            Text("\(Date(timeIntervalSince1970: TimeInterval(((Int)(weatherModelData.forecast?.current.dt ?? 0)))).formatted(.dateTime.year().hour().month().day()))")
                                .fontWeight(.light)
                        }

                        Spacer()
                        
                        Image(systemName: weatherModelData.currentTimeOfDay == TimeOfDay.morning ? "sunrise.fill" : weatherModelData.currentTimeOfDay == TimeOfDay.afternoon ? "sun.max.fill" : "moon.fill")
                            .symbolRenderingMode(.multicolor)
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        BufferingImage(imageUrl: "https://openweathermap.org/img/wn/\(weatherModelData.forecast!.current.weather[0].icon)@2x.png")
                        Text("\(weatherModelData.forecast!.current.weather[0].weatherDescription.rawValue)")
                    }
                    
                    Spacer()
                    
                    Text("\((Int)(weatherModelData.convertMetric(weatherModelData.forecast!.current.temp)))\(weatherModelData.unit.rawValue)")
                        .font(.system(size: 100))
                        .fontWeight(.bold)
                        .padding()
                    
                    Button {
                        self.isSearchOpen.toggle()
                    } label: {
                        Text("Change Location")
                            .fontWeight(.semibold)
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                    .sheet(isPresented: $isSearchOpen) {
                        SearchView(isSearchOpen: $isSearchOpen, userLocation: $userLocation)
                    }
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
                
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            WeatherRow(logo: "thermometer", name: "Min temp", value: "\((Int)(weatherModelData.convertMetric(weatherModelData.forecast!.daily[0].temp.min)))\(weatherModelData.unit.rawValue)")
                            Spacer()
                            WeatherRow(logo: "thermometer", name: "Max temp", value: "\((Int)(weatherModelData.convertMetric(weatherModelData.forecast!.daily[0].temp.max)))\(weatherModelData.unit.rawValue)")
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
                    FetchingData(information: "Fetching Weather Data")
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
