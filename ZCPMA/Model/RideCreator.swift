//
//  RideCreator.swift
//  ZCPMA
//
//  Created by ZIYUAN CHEN on 7/31/18.
//  Copyright © 2018 Sheprd. All rights reserved.
//

import Foundation

enum FavoredType: String {
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
  var explanation: String {
    switch self {
    case .Departure:
      return "Favoring Departure generates more accurate pickup window"
    case .Arrival:
      return "Favoring Arrival generates more accurate drop-off window"
    }
  }
  var rideTimeLabel: String {
    switch self {
    case .Departure:
      return "Pick Up At"
    case .Arrival:
      return "Drop Off By"
    }
  }
}

extension Notification.Name {
  static let SheprdStartDateChange = Notification.Name(rawValue: "SheprdStartDateChange")
}

class RideCreator {
  static let shared = RideCreator()
  
  var favored: FavoredType = .Departure
  var riders: [GetMemberQuery.Data.Member.Student] = []
  var recurring: Bool = false
  var startDate: Date = Date() {
    didSet {
      NotificationCenter.default.post(Notification(
        name: Notification.Name.SheprdStartDateChange,
        object: self,
        userInfo: ["startDate": startDate]
      ))
    }
  }
  var endDate: Date = Date()
  var excludingDates: [Date] = []
  var repeatDays: [WeekDay] = []
  
  func resetForMember(member: GetMemberQuery.Data.Member) {
    favored = .Departure
    riders = member.students ?? []
    recurring = false
    startDate = Date()
    endDate = Date()
    excludingDates = []
    repeatDays = []
  }
}
