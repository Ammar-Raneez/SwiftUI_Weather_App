//
//  CalendarHelper.swift
//  CourseWork2Starter
//
//  Created by Ammar on 2023-05-08.
//

import Foundation

func greetingLogic() -> TimeOfDay {
    let hour = Calendar.current.component(.hour, from: Date())
    
    let NEW_DAY = 0
    let NOON = 12
    let SUNSET = 18
    let MIDNIGHT = 24
    
    var greetingText = TimeOfDay.morning
    
    switch hour {
    case NEW_DAY..<NOON:
        greetingText = TimeOfDay.morning
    case NOON..<SUNSET:
        greetingText = TimeOfDay.afternoon
    case SUNSET..<MIDNIGHT:
        greetingText = TimeOfDay.evening
    default:
        greetingText = TimeOfDay.morning
    }
   
    return greetingText
}
