//
//  SceneDelegate.swift
//  OviaTakeHome
//
//  Created by Jian Ma on 3/6/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScence = (scene as? UIWindowScene) else { return }
        let navController = UINavigationController()
        let window = UIWindow(windowScene: windowScence)
        window.rootViewController = navController
        navController.viewControllers = [ViewController()]
        window.makeKeyAndVisible()
        self.window = window
    }
}

