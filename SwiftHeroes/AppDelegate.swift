//
//  SwiftHeroesApp.swift
//  SwiftHeroes
//
//  Created by Gaetano Matonti on 04/03/22.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = RootTabViewController()
    window?.makeKeyAndVisible()
    
    return true
  }
}
