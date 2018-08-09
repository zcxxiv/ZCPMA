//
//  DatabaseManager.swift
//  ZCPMA
//
//  Created by ZIYUAN CHEN on 7/31/18.
//  Copyright © 2018 Sheprd. All rights reserved.
//

import Foundation

class DatabaseManager {
  
  static func getMember(
    memberId: String,
    completion: @escaping (
      _ member: MemberFragment?,
      _ memberLocations: [LocationFragment]?,
      _ error: Error?) -> Void)
  {
    apollo.fetch(query: GetMemberQuery(memberId: memberId)) { result, error in
      if error == nil,
        let member = result?.data?.member,
        let locations = result?.data?.memberLocations {
        let memberLocations: [LocationFragment]? = locations.map { $0.fragments.locationFragment }
        completion( member.fragments.memberFragment, memberLocations, nil)
      } else {
        completion(nil, nil, error)
      }
    }
  }
  
  static func getLocationsByPlaceIds(
    placeIds: [String],
    memberId: String,
    completion: @escaping ( _ locations: [LocationFragment]?, _ error: Error?) -> Void) {
    apollo.fetch(query: GetLocationByPlaceIdsQuery(
      placeIds: placeIds,
      memberId: memberId)) { result, error in
        if error == nil, let locations = result?.data?.locations {
          completion(locations.map {$0.fragments.locationFragment}, nil)
        } else {
          completion(nil, error)
        }
    }
  }
  
}
