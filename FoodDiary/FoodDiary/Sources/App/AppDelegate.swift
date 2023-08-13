//
//  AppDelegate.swift
//  FoodDiary
//
//  Created by Suhong Jeong on 2023/02/21.
//

import UIKit
import FirebaseCore
import RxFlow

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var shared: AppDelegate { UIApplication.shared.delegate as! AppDelegate }
    var window: UIWindow?
    var coordinator = FlowCoordinator()
    
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
      
      let window = UIWindow(frame: UIScreen.main.bounds)
      window.makeKeyAndVisible()
      self.window = window
      
      if #available(iOS 15.0, *) {
        UITableView.appearance().sectionHeaderTopPadding = 0
      }
      
      setupFirebase()
      setupFlow()
      
    return true
  }


}

extension AppDelegate {
    private func setupFirebase() {
        guard let path = Bundle.main.path(forResource: Environment.firebaseResource, ofType: "plist"),
              let option = FirebaseOptions(contentsOfFile: path) else { return }
        
        FirebaseApp.configure(options: option)
    }
    
    private func setupFlow() {
        guard let window else { return }
        
        let flow = AppFlow(window: window)
        self.coordinator.coordinate(flow: flow, with: AppStepper())
        Flows.use(flow, when: .created) { _ in }
    }
}


