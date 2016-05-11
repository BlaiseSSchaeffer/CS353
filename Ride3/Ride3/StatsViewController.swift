//
//  StatsViewController.swift
//  Ride3
//
//  Created by Blaise Schaeffer on 5/6/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    @IBOutlet weak var numberOfRidesLabel: UILabel!
    @IBOutlet weak var totalDistanceLabel: UILabel!
    @IBOutlet weak var averageDistanceLabel: UILabel!
    @IBOutlet weak var longestRideLabel: UILabel!
    @IBOutlet weak var shortestRideLabel: UILabel!
    @IBOutlet weak var longestTimeLabel: UILabel!
    @IBOutlet weak var shortestTimeLabel: UILabel!
    
    var numberOfRides: Int = 0
    var totalDistance: Float = 0
    var averageDistancePerRide: Float = 0
    var longestRideDistance: Float = 0
    var shortestRide: Float = Float.infinity
    var longestTime: Float = 0
    var shortestTime: Float = Float.infinity
    
    var defaults = NSUserDefaults.standardUserDefaults()
    var entries: [RideEntry]?
    
    private struct Storyboard {
        static let RideEntreisObjectKey = "SavedRideEntries"
    }

    @IBAction func done(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) {}
    }
    
    override func viewWillAppear(animated: Bool) {
        if let decodedEntries = defaults.objectForKey(Storyboard.RideEntreisObjectKey) as? NSData {
            if let rideEntries = NSKeyedUnarchiver.unarchiveObjectWithData(decodedEntries) as? [RideEntry] {
                entries = rideEntries
                
                for ride in entries! {
                    numberOfRides += 1
                    let distance = ride.distance!
                    totalDistance += distance
                    if (distance > longestRideDistance) {
                        longestRideDistance = distance
                    }
                    if (distance < shortestRide) {
                        shortestRide = distance
                    }
                    let time = ride.time!
                    if (time > longestTime) {
                        longestTime = time
                    }
                    if (time < shortestTime) {
                        shortestTime = time
                    }
                }
                averageDistancePerRide = totalDistance / Float (numberOfRides)
                
                numberOfRidesLabel.text = "\(numberOfRides)"
                totalDistanceLabel.text = "\(totalDistance)"
                averageDistanceLabel.text = "\(averageDistancePerRide)"
                longestRideLabel.text = "\(longestRideDistance)"
                shortestRideLabel.text = "\(shortestRide)"
                longestTimeLabel.text = "\(longestTime)"
                shortestTimeLabel.text = "\(shortestTime)"
            }
        }
    }
}
