//
//  SearchView.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI
import CoreLocation

struct SearchView: View {
    
    @EnvironmentObject var weatherModelData: WeatherModelData
    @Binding var isSearchOpen: Bool
    @Binding var userLocation: String
    @State var location = ""
    @State var isLocationInvalid = false
    
    var body: some View {
        ZStack {
            Color(hue: 0.656, saturation: 0.787, brightness: 0.354)
                .ignoresSafeArea()

            VStack{
                TextField("Enter New Location", text: self.$location, onCommit: {
                    CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
                        isLocationInvalid = false
                        
                        if (error != nil) {
                            isLocationInvalid = true
                        }
                        
                        if let lat = placemarks?.first?.location?.coordinate.latitude,
                           let lon = placemarks?.first?.location?.coordinate.longitude {
                            Task {
                                let _ = try await weatherModelData.loadData(lat: lat, lon: lon)
                                userLocation = location
                                weatherModelData.userLocation = location
                            }

                            isSearchOpen.toggle()
                        }
                    }
                })
                .padding(10)
                .fixedSize()
                .font(.custom("Arial", size: 26))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(15)
                
            }
        }
        .alert(isPresented: $isLocationInvalid) {
            Alert(title: Text("Invalid location"),message: Text("We could not detect your specified location, please ensure that there aren't any spelling errors or that the location exists."), dismissButton: .default(Text("Ok")))
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(isSearchOpen: .constant(true), userLocation: .constant("Sample location"))
            .environmentObject(WeatherModelData())
    }
}
