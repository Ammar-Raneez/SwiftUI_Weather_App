//
//  AirModelData.swift
//  CourseWork2
//  Handles API requests with the required Air Pollution API
//  Created by Ammar on 2023-05-01.
//

import Foundation

@MainActor
class AirModelData: ObservableObject {
    
    @Published var pollution: Pollution?
    @Published var alertItem: AlertItem?
    @Published var isPollutionLoading = false

    init() {}
    
    func loadAirPollution(lat: Double, lon: Double) async throws {
        isPollutionLoading = true

        guard let APP_ID = Bundle.main.infoDictionary?["OPEN_WEATHER_MAP_APP_ID"] as? String else {
            isPollutionLoading = false
            alertItem = AlertContext.invalidResponse
            fatalError("Could not load OPEN_WEATHER_MAP_APP_ID from environment")
        }

        let url = URL(string: "https://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=\(lat)&lon=\(lon)&units=metric&appid=\(APP_ID)")
        
        let session = URLSession(configuration: .default)

        do {
            let (data, _) = try await session.data(from: url!)
            let pollutionData = try JSONDecoder().decode(Pollution.self, from: data)

            DispatchQueue.main.async {
                self.pollution = pollutionData
            }

            isPollutionLoading = false
        } catch {
            isPollutionLoading = false
            alertItem = AlertContext.invalidResponse
            print("Error loading data air pollution data from Open Weather Map: \(error.localizedDescription)")
            throw error
        }
    }
}
