//
//  CourseWork2StarterApp.swift
//  CourseWork2Starter
//
//  Created by GirishALukka on 16/03/2023.
//

import SwiftUI

@main
struct CourseWork2StarterApp: App {
    @StateObject var weatherModelData = WeatherModelData()
    @StateObject var airModelData = AirModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(weatherModelData)
                .environmentObject(airModelData)
        }
    }
}
