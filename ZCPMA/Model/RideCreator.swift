//
//  RideCreator.swift
//  ZCPMA
//
//  Created by ZIYUAN CHEN on 7/31/18.
//  Copyright © 2018 Sheprd. All rights reserved.
//

import Foundation

enum Favored: String {
  case Departure = "Departure"
  case Arrival = "Arrival"
  mutating func toggle() {
    switch self {
    case .Departure:
      self = .Arrival
    case .Arrival:
      self = .Departure
    }
  }
}

extension Notification.Name {
  static let SheprdStartDateChange = Notification.Name(rawValue: "SheprdStartDateChange")
}

class RideCreator {
  static let shared = RideCreator()
  
  var favored: Favored = .Departure
  var riders: [GetMemberQuery.Data.Member.Student] = []
  var recurring: Bool = false
  var startDate: Date = Date() {
    didSet {
      if endDate < startDate {
        endDate = startDate
      }
      NotificationCenter.default.post(Notification(
        name: Notification.Name.SheprdStartDateChange,
        object: self,
        userInfo: nil
      ))
    }
  }
  var endDate: Date = Date()
  var excludingDates: [Date] = []
  var repeatDays: Set<WeekDay> = WeekDay.allWeekDays()
  

  var selectedDatesBeforeExcluding: [Date] {
    return Date.getDatesBetween(startDate, endDate).filter(isInRepeatDays)
  }
  
  var selectedDatesAfterExcluding: [Date] {
    return selectedDatesBeforeExcluding.difference(from: excludingDates)
  }
  
  private func isInRepeatDays(date: Date) -> Bool {
    let weekdayValue = Calendar.current.component(.weekday, from: date)
    return repeatDays.contains { $0.intValue() == weekdayValue }
  }
  
  func resetForMember(member: GetMemberQuery.Data.Member) {
    favored = .Departure
    riders = member.students ?? []
    recurring = false
    startDate = Date()
    endDate = Date()
    excludingDates = []
    repeatDays = WeekDay.allWeekDays()
  }
  
  static func getExcludingDates(beforeExcluding: [Date], afterExcluding: [Date]) -> [Date] {
    return beforeExcluding.difference(from: afterExcluding)
  }
}

extension Array where Element: Hashable {
  func difference(from other: [Element]) -> [Element] {
    let thisSet = Set(self)
    let otherSet = Set(other)
    return Array(thisSet.symmetricDifference(otherSet))
  }
}

fileprivate extension WeekDay {
  static func allWeekDays() -> Set<WeekDay> {
    return [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
  }
}
