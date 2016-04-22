//
//  AppDelegate.swift
//  Trax
//
//  Created by Blaise Schaeffer on 4/21/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

struct GPXURL {
    static let Noritification = "GPXURL Radio Station"
    static let Key = "GPXURL URL Key"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        let center = NSNotificationCenter.defaultCenter()
        let notification = NSNotification(name: GPXURL.Noritification, object: self, userInfo: [GPXURL.Key: url])
        center.postNotification(notification)
        return true
    }


}

