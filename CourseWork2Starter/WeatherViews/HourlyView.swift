//
//  HourlyView.swift
//  Coursework2
//
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

            VStack {
                Text("\(weatherModelData.userLocation)")
                    .font(.largeTitle)
                    .shadow(color: .black, radius: 0.5)
                
                List {
                    ForEach(weatherModelData.forecast!.hourly) { hour in
                        HourCondition(current: hour)
                    }
                }
            }
            .opacity(0.8)
        }
    }
}

struct Hourly_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView().environmentObject(WeatherModelData())
    }
}
