//
//  AppDelegate.swift
//  NetworkLayer_Pet
//
//  Created by Evgeniy Stoyan on 20.09.2024.
//

import UIKit
import NetworkAPI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy private var appManager = AppManager(window: window)

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appManager.loadPostsViewController()
        return true
    }
}


class AppManager {
    private let window: UIWindow
    
    init(window: UIWindow?) {
        self.window = window ?? UIWindow(frame: UIScreen.main.bounds)
    }
    
    func loadPostsViewController() {
        let service = HTTPManager()
        let controller = PostsViewController(networkService: service)
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
}
