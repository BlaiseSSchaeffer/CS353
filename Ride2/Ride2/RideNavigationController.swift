//
//  RideNavigationController.swift
//  Ride2
//
//  Created by Blaise Schaeffer on 4/27/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

class RideNavigationController: UINavigationController {
    
    var navBarTintColor: UIColor = UIColor(colorLiteralRed: 76/255, green: 175/255, blue: 80/255, alpha: 1.0)
    var navBarTitleColor: UIColor = UIColor(colorLiteralRed: 205/255, green: 220/255, blue: 57/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = navBarTintColor
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: navBarTitleColor]
    }

}
