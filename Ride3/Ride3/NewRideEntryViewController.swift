//
//  NewRideEntryViewController.swift
//  Ride3
//
//  Created by Blaise Schaeffer on 4/30/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

class NewRideEntryViewController: UIViewController {
    
    var rideEntry: RideEntry?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var distanceField: UITextField!
    
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) {}
    }
    
    @IBAction func save(sender: AnyObject) {
        if let title = titleField.text {
            if let distance = distanceField.text {
                rideEntry = RideEntry(rideTitle: title, distance: (distance as NSString).floatValue)
                print(rideEntry!.title, rideEntry!.distance)
            }
        }
    }

}
