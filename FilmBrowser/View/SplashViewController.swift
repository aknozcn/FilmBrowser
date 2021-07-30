//
//  SplashViewController.swift
//  FilmBrowser
//
//  Created by Akin O. on 29.07.2021.
//

import UIKit
import Firebase
import Network

class SplashViewController: UIViewController, Storyboardable {

    @IBOutlet weak var titleLabel: UILabel!
    var remoteConfig = RemoteConfig.remoteConfig()
    var checkDataConnection = true

    override func viewDidLoad() {
        super.viewDidLoad()
        getRemoteTitle()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkConnection()
    }

    func getRemoteTitle() {
        remoteConfig.fetch(withExpirationDuration: 0) { [unowned self]
            (response, error) in
            guard error == nil else { return }
            print(response)
            remoteConfig.activate()
            self.setRemoteTitle()
        }
    }

    func setRemoteTitle() {
        titleLabel.isHidden = false
        titleLabel.text = remoteConfig.configValue(forKey: "splashTitle").stringValue!
    }

    func checkConnection() {
        if !checkDataConnection {
            titleLabel.isHidden = false
            titleLabel.text = "No Connection"
        }
    }
}
