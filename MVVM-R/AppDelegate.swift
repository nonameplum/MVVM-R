//
//  AppDelegate.swift
//  MVVM-R
//
//  Created by Łukasz Śliwiński on 13/09/16.
//  Copyright © 2016 Plum's organization. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()

        return AppContext.sharedInstance.openRoute(.Users)
    }

}
