//
//  SceneDelegate.swift
//  HackingWithSwiftProject7
//
//  Created by Chen, Sihan on 2020-03-30.
//  Copyright © 2020 Chen, Sihan. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
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
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

