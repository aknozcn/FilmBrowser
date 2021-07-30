//
//  AppDelegate.swift
//  FilmBrowser
//
//  Created by Akin O. on 27.07.2021.
//

import UIKit
import Firebase
import Network
import SystemConfiguration
@main

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let network = NetworkConnection()
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()

        let viewController = SplashViewController.instantiate()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        if network.isConnectedToNetwork() {
            viewController.checkDataConnection = true
            Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.goToMainView), userInfo: nil, repeats: false)
        } else {
            viewController.checkDataConnection = false
        }

        return true
    }


    @objc func goToMainView() {
        let viewController = MovieSearchViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: viewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

