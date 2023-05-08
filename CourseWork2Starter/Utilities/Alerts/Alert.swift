//
//  Alert.swift
//  CourseWork2
//  Alert handlers
//  Created by Ammar on 2023-05-07.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    // MARK: Network Alerts
    static let invalidResponse = AlertItem(title: Text("Server Error"), message: Text("Invalid response from the server. Please try again later or contact support"), dismissButton: .default(Text("Ok")))

    static let unableToComplete = AlertItem(title: Text("Server Error"), message: Text("Unable to complete your request at this time. Please check your internet connection."), dismissButton: .default(Text("Ok")))
    
    // MARK: Form Alerts
    static let invalidForm = AlertItem(title: Text("Invalid Location"), message: Text("We could not detect your specified location, please ensure that there aren't any spelling errors or that the location exists."), dismissButton: .default(Text("Ok")))
}
