//
//  AirStructures.swift
//  CourseWork2
//  Codable Air Pollution interfaces for API access
//  Created by Ammar on 2023-03-31.
//

import Foundation

struct Pollution: Codable {
    let coord: Coord
    let list: [AirList]
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct AirList: Codable {
    let main: AirMain
    let components: AirComponents
    let dt: Int
}

struct AirMain: Codable {
    let aqi: Int
}

struct AirComponents: Codable {
    let co: Double
    let no: Double
    let no2: Double
    let o3: Double
    let so2: Double
    let pm2_5: Double
    let pm10: Double
    let nh3: Double
}
