//
//  WAQError.swift
//  CourseWork2
//  Alert handlers
//  Created by Ammar on 2023-05-07.
//

import Foundation

enum WAQNetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}

enum WAQFormError: Error {
    case invalidLocation
}
