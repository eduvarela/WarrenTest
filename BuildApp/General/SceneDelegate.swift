//
//  SceneDelegate.swift
//  BuildApp
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let mainViewController = MainViewController()
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UINavigationController.init(rootViewController: mainViewController)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

