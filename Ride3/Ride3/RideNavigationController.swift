//
//  RideNavigationController.swift
//  Ride3
//
//  Created by Blaise Schaeffer on 4/28/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

class RideNavigationController: UINavigationController {
    
    let greenBackgroundColor: UIColor = UIColor(colorLiteralRed: 76/255, green: 175/255, blue: 80/255, alpha: 1.0)
    let limeTextColor: UIColor = UIColor(colorLiteralRed: 205/255, green: 220/255, blue: 57/255, alpha: 1.0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = greenBackgroundColor
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: limeTextColor]
        self.navigationBar.tintColor = limeTextColor
    }
    

}
