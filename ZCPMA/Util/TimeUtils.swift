//
//  TimeUtils.swift
//  ZCPMA
//
//  Created by ZIYUAN CHEN on 8/1/18.
//  Copyright © 2018 Sheprd. All rights reserved.
//

import Foundation

extension Date {
  static func getDatesBetween(_ start: Date, _ end: Date)-> [Date] {
    var dates: [Date] = []
    var date = start
    while date <= end {
      dates.append(date)
      date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
    }
    return dates
  }
  func startOfDay() -> Date {
    return Calendar.current.startOfDay(for: self)
  }
}

enum WeekDay: String {
  case monday = "Monday"
  case tuesday = "Tuesday"
  case wednesday = "Wednesday"
  case thursday = "Thursday"
  case friday = "Friday"
  case saturday = "Saturday"
  case sunday = "Sunday"

  func intValue() -> Int {
    switch self {
    case .sunday: return 1
    case .monday: return 2
    case .tuesday: return 3
    case .wednesday: return 4
    case .thursday: return 5
    case .friday: return 6
    case .saturday: return 7
    }
  }
}

