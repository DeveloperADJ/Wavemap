//
//  TimeDateModel.swift
//  Wavemap
//
//  Created by Arno de Jonge on 26/05/2017.
//  Copyright © 2017 Arno de Jonge. All rights reserved.
//

import Foundation

let date = Date()
let calendar = Calendar.current
let components = calendar.dateComponents([.minute, .hour, .day, .month, .year], from: date)

let minute = components.minute
let hour = components.hour
let day = components.day
let month = components.month
let year = components.year

func currentTime(hour: Int, minute: Int) -> String {

    return "\(hour):\(minute)"
    
}

func timeUntilEvent(){

}

enum eventTimes {
    
    case currentTime((Date, Date) -> String)
    case timeUntilEvent
    
}

