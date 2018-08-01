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
    completion: @escaping (_ member: GetMemberQuery.Data.Member?, _ error: Error?) -> Void)
  {
    apollo.fetch(query: GetMemberQuery(memberId: memberId)) { result, error in
      if error == nil {
        completion(result?.data?.member, nil)
      } else {
        completion(nil, error)
      }
    }
  }
  
}
