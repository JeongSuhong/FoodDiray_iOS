//
//  AppDelegate.swift
//  FoodDiary
//
//  Created by Suhong Jeong on 2023/02/21.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
      
      setupFirebase()
      
    return true
  }


}

extension AppDelegate {
    private func setupFirebase() {
        guard let path = Bundle.main.path(forResource: Environment.firebaseResource, ofType: "plist"),
              let option = FirebaseOptions(contentsOfFile: path) else { return }
        
        FirebaseApp.configure(options: option)
    }
}

