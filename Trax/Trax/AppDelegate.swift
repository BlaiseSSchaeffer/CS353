//
//  AppDelegate.swift
//  Trax
//
//  Created by Blaise Schaeffer on 4/21/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        print("url = \(url)")
        return true
    }


}

