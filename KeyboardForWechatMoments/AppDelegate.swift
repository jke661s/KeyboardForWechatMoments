//
//  AppDelegate.swift
//  KeyboardForWechatMoments
//
//  Created by Jackie Wang on 29/2/20.
//  Copyright © 2020 Jackie Wang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }


}

