//
//  RideCreator.swift
//  ZCPMA
//
//  Created by ZIYUAN CHEN on 7/31/18.
//  Copyright © 2018 Sheprd. All rights reserved.
//

import Foundation
import GooglePlaces

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

enum RideActionType {
  case Pickup, DropOff
}

struct GooglePlacesLocation {
  let primaryAddress: String
  let secondaryAddress: String
}

extension Notification.Name {
  static let SheprdStartDateChange = Notification.Name(rawValue: "SheprdStartDateChange")
  static let SheprdPickupLocationChange = Notification.Name(rawValue: "SheprdPickupLocationChange")
  static let SheprdDropOffLocationChange = Notification.Name(rawValue: "SheprdDropOffLocationChange")
  static let ShperdSelectableLocationsChange =
    Notification.Name(rawValue: "ShperdSelectableLocationsChange")
}

extension StudentFragment: Equatable {
  public static func == (lhs: StudentFragment, rhs: StudentFragment) -> Bool {
    return lhs.id == rhs.id
  }
}

class RideCreator {
  static let shared = RideCreator()
  
  var allRiders: [MemberFragment.Student] = []
  var riders: [MemberFragment.Student] = []
  
  // MARK: - Ride Dates
  
  var favored: Favored = .Departure
  var recurring: Bool = false {
    didSet {
      if (!recurring) {
        excludingDates = []
      }
    }
  }
  var startDate: Date = Date() {
    didSet {
      if endDate < startDate {
        endDate = startDate
      }
      NotificationCenter.default.post(Notification(name: .SheprdStartDateChange))
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
  
  // MARK: - Ride Time
  
  var rideTime: Date? = nil

  // MARK: - Ride Location
  
  static let placesClient = GMSPlacesClient()
  static var memoizedSelectableLocations: [String: [Location]] = [:]
  var locationTypeToEdit: RideActionType = .Pickup
  
  var pickupLocation: Location? {
    didSet {
      NotificationCenter.default.post(Notification(name: .SheprdPickupLocationChange))
      selectableLocations = defaultSelectableLocations
    }
  }
  
  var dropOffLocation: Location? {
    didSet {
      NotificationCenter.default.post(Notification(name: .SheprdDropOffLocationChange))
      selectableLocations = defaultSelectableLocations
    }
  }

  
  class Location {
    var id: String?
    let title: String
    let secondaryDescription: String
    let formattedAddress: String
    let placeId: String
    var isSheprdLocation: Bool {
      return id != nil
    }
    var isRecentLocation: Bool {
      return RideCreator.shared.defaultSelectableLocations.contains { $0.id == id }
    }

    init(googlePlace: GMSAutocompletePrediction) {
      title = googlePlace.attributedPrimaryText.string
      secondaryDescription = googlePlace.attributedSecondaryText?.string ?? ""
      formattedAddress = googlePlace.attributedFullText.string
      placeId = googlePlace.placeID ?? ""
    }
    
    init(sheprdLocation: LocationFragment) {
      id = sheprdLocation.id
      title = sheprdLocation.title
      secondaryDescription = sheprdLocation.formattedAddress
      formattedAddress = sheprdLocation.formattedAddress
      placeId = sheprdLocation.placeId
    }
    
  }
  
  var defaultSelectableLocations: [RideCreator.Location] = []
  var selectableLocations: [RideCreator.Location] = [] {
    didSet {
      NotificationCenter.default.post(Notification(name: .ShperdSelectableLocationsChange))
    }
  }
  
  var locationSearchInput: (RideActionType, String?) = (.Pickup, nil) {
    didSet {
      guard let query = locationSearchInput.1 else { return }
      if query.isEmpty {
        selectableLocations = defaultSelectableLocations
      } else {
        placeAutocomplete(query: query)
      }
    }
  }
  
  private func placeAutocomplete(query: String) {
    if let memoized = RideCreator.memoizedSelectableLocations[query] {
      self.selectableLocations = memoized
      return
    }
    let filter = GMSAutocompleteFilter()
    filter.country = "us"
    RideCreator.placesClient.autocompleteQuery(
      query,
      bounds: nil,
      filter: filter,
      callback: { [weak self] (results, error) -> Void in
        guard error == nil, let results = results else {
          print("Autocomplete error \(error!)")
          return
        }
        let selectableLocations = results.map(RideCreator.Location.init)
        DatabaseManager.getLocationsByPlaceIds(
          placeIds: results.map {$0.placeID!},
          memberId: "cjkibyszw1m3q0186mksot14r") { [weak self] (locations, error) in
            guard error == nil, let sheprdLocations = locations else {
              self?.selectableLocations = selectableLocations
              RideCreator.memoizedSelectableLocations[query] = selectableLocations
              return
            }
            for location in selectableLocations {
              if let sheprdLocation = (sheprdLocations.first {
                $0.places?.contains { $0.placeId == location.placeId } ?? false
              }) {
                location.id = sheprdLocation.id
              }
            }
            self?.selectableLocations = selectableLocations
            RideCreator.memoizedSelectableLocations[query] = selectableLocations
        }
    })
  }
  
  // MARK: - Common
  
  func resetForMember(member: MemberFragment, locations: [LocationFragment]) {
    favored = .Departure
    allRiders = member.students ?? []
    riders = member.students ?? []
    recurring = false
    startDate = Date()
    endDate = Date()
    rideTime = nil
    excludingDates = []
    repeatDays = WeekDay.allWeekDays()
    defaultSelectableLocations = locations.map(RideCreator.Location.init)
    selectableLocations = defaultSelectableLocations
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
