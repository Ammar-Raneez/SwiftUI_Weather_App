//
//  AirModelData.swift
//  CourseWork2Starter
//
//  Created by Ammar on 2023-05-01.
//

import Foundation

class AirModelData: ObservableObject {
    
    @Published var pollution: Pollution?
    
    
    init() {}
    
    func loadAirPollution(lat: Double, lon: Double) async throws {
        guard let APP_ID = Bundle.main.infoDictionary?["OPEN_WEATHER_MAP_APP_ID"] as? String else {
            fatalError("Could not load OPEN_WEATHER_MAP_APP_ID from environment")
        }

        let url = URL(string: "https://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=\(lat)&lon=\(lon)&units=metric&appid=\(APP_ID)")
        
        let session = URLSession(configuration: .default)
        
        let (data, _) = try await session.data(from: url!)
        
        do {
            let pollutionData = try JSONDecoder().decode(Pollution.self, from: data)
            DispatchQueue.main.async {
                self.pollution = pollutionData
            }
        } catch {
            print("Error loading data air pollution data from Open Weather Map: \(error.localizedDescription)")
            throw error
        }
    }
}
