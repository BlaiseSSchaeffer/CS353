//
//  RideEntry.swift
//  Ride3
//
//  Created by Blaise Schaeffer on 4/30/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

class RideEntry {
    var title: String?
    var distance: Float?
    
    init(rideTitle: String, distance: Float) {
        self.title = rideTitle
        self.distance = distance
    }
    
    init(json: [String: AnyObject]) {
        self.title = json["title"] as? String
        self.distance = json["distance"] as? Float
    }
}