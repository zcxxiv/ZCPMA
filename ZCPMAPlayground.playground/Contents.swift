//: Playground - noun: a place where people can play

import UIKit
import Foundation

let formatter = DateFormatter()
formatter.dateFormat = "yyyy-MM-dd"
let date1 = formatter.date(from: "2018-07-26")!
let date2 = formatter.date(from: "2018-11-02")!

public enum WeekDay: String, CaseIterable {
  case sunday = "Sunday"
  case monday = "Monday"
  case tuesday = "Tuesday"
  case wednesday = "Wednesday"
  case thursday = "Thursday"
  case friday = "Friday"
  case saturday = "Saturday"
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

extension Date {
  static func getDates(from start: Date, to end: Date)-> [Date] {
    var dates: [Date] = []
    var date = start
    while date <= end {
      dates.append(date)
      date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
    }
    return dates
  }
}

let oneMonth = DateComponents(
let components = Calendar.current.dateComponents([.year, .month], from: date2)


Calendar.current.date(
  from: components)
