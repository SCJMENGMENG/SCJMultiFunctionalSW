//
//  AppDelegate.swift
//  SCJMultiFunctionalSW
//
//  Created by scj on 2021/5/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = SCJNavigationController.init(rootViewController: ListTableViewController.init())
        
        //dyIcon
        UIViewController.initializeMethod()
        
        return true
    }


}

