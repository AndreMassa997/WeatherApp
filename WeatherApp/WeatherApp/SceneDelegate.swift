//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Andrea Massari on 30/01/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        AppPreferences.shared.palette = UITraitCollection.current.userInterfaceStyle == .dark ? DarkPalette() : LightPalette()
        
        let mainViewModel = MainViewModel(dataProvider: NetworkManager())
        let viewController = MainViewController(viewModel: mainViewModel)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        self.window?.backgroundColor = AppPreferences.shared.palette.barBackgroundColor
        self.window = window
        window.makeKeyAndVisible()
    }
}

