//
//  AppDelegate.swift
//  Bouncer
//
//  Created by Blaise Schaeffer on 4/21/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit
import CoreMotion

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    struct Motion {
        static let Manager = CMMotionManager()
    }

}

