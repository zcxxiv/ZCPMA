//
//  Env.swift
//  ZCPMA
//
//  Created by ZIYUAN CHEN on 7/28/18.
//  Copyright © 2018 Sheprd. All rights reserved.
//

import Foundation

struct Env {
  static func graphQLEndpoint() -> String {
    return "https://api.graph.cool/simple/v1/zcaugust"
  }
  
  static func googleMapsAPIKey() -> String {
    return "AIzaSyB2aLY1wbCUH53SSfzfI4ceBXy4_rfUyM0"
  }
  
  static func googlePlacesAPIKey() -> String {
    return "AIzaSyB8Ym9IShpC73kYwltbL9PJS1WXpjpBLD4"
  }
}
