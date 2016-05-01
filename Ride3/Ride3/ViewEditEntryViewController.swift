//
//  ViewEditEntryViewController.swift
//  Ride3
//
//  Created by Blaise Schaeffer on 4/30/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

class ViewEditEntryViewController: UIViewController {
    
    var rideEntry: RideEntry? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    func updateUI() {
//        titleLabel.text = rideEntry?.title
//        distanceLabel.text = "\(rideEntry?.distance)"
    }
}
