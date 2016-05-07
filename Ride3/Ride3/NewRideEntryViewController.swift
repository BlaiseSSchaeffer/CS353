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
    var defaults = NSUserDefaults.standardUserDefaults()
    
    private struct Storyboard {
        static let RideEntreisObjectKey = "SavedRideEntries"
    }
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var distanceField: UITextField!
    
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) {}
    }
    
    @IBAction func save(sender: AnyObject) {
        if let title = titleField.text where title != "" {
            if let distance = distanceField.text {
                rideEntry = RideEntry(rideTitle: title, distance: (distance as NSString).floatValue)
                
                if let decodedEntries = defaults.objectForKey(Storyboard.RideEntreisObjectKey) as? NSData {
                    if var entries = NSKeyedUnarchiver.unarchiveObjectWithData(decodedEntries) as? [RideEntry] {
                        entries.insert(rideEntry!, atIndex: 0)
                        
                        let encodedEntries = NSKeyedArchiver.archivedDataWithRootObject(entries)
                        defaults.setObject(encodedEntries, forKey: Storyboard.RideEntreisObjectKey)
                    }
                }
            }
        }
        self.dismissViewControllerAnimated(true) {}
    }

}
