//
//  AppDelegate.swift
//  ZCPMA
//
//  Created by ZIYUAN CHEN on 7/28/18.
//  Copyright © 2018 Sheprd. All rights reserved.
//

import UIKit
import Apollo

let apollo = ApolloClient(url: URL(string: Env.graphQLEndpoint())!)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    UIApplication.shared.statusBarStyle = .lightContent
    UIFont.overrideInitialize()

    apollo.cacheKeyForObject = { $0["id"] }
    
    let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    self.window?.rootViewController =
      storyboard.instantiateViewController(withIdentifier: "InitialViewController")
    
    return true
  }

}

