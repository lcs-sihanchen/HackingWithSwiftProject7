//
//  AppDelegate.swift
//  HackingWithSwiftProject7
//
//  Created by Chen, Sihan on 2020-03-30.
//  Copyright © 2020 Chen, Sihan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // Override point for customization after application launch.
        // rootViewController is the initial controller, in this case it is supposed to be the ViewController, but it's embedded in a navigation controller that is embedded in a tab bar controller, therefore here it is a UITabBarController
        if let tabBarController = window?.rootViewController as? UITabBarController {
            // Since we need to create a new view controller, we need a reference to our storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // Create the view controller wrapped in the navigation controller using this method
            // We want the navigation controller to be passed in (Using the Storyboard ID we give before)
            let vc = storyboard.instantiateViewController(withIdentifier:"NavController")
            // Create a new tab bar item with toprated icon
            // Use tag 1 for identification
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
            // add the new view controller into the tab bar controller's view controller array
            // Now there is one view controller in each tab
            // The same code will be executed in this new view controller
            tabBarController.viewControllers?.append(vc)
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

