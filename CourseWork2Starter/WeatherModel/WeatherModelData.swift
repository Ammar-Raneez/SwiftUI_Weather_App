//
//  WeatherModelData.swift
//  Coursework2
//
//  Created by G Lukka.
//

import Foundation

class WeatherModelData: ObservableObject {

    @Published var forecast: Forecast?
    @Published var userLocation: String = ""

    init() {
        self.forecast = load("london.json")
    }

    func loadData(lat: Double, lon: Double) async throws -> Forecast {
        guard let APP_ID = Bundle.main.infoDictionary?["OPEN_WEATHER_MAP_APP_ID"] as? String else {
            fatalError("Could not load OPEN_WEATHER_MAP_APP_ID from environment")
        }

        let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=\(APP_ID)")
    
        let session = URLSession(configuration: .default)
        
        let (data, _) = try await session.data(from: url!)
        
        do {
            let forecastData = try JSONDecoder().decode(Forecast.self, from: data)
            DispatchQueue.main.async {
                self.forecast = forecastData
            }
            
            return forecastData
        } catch {
            print("Error loading data one call data from Open Weather Map: \(error.localizedDescription)")
            throw error
        }
    }
    
    func load<Forecast: Decodable>(_ filename: String) -> Forecast {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Forecast.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(Forecast.self):\n\(error)")
        }
    }
}
