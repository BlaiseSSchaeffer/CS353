//
//  RideEntry.swift
//  Ride3
//
//  Created by Blaise Schaeffer on 4/30/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

class RideEntry: NSObject, NSCoding {
    var title: String?
    var distance: Float?
    var time: Float?

    
    init(rideTitle: String, distance: Float, time: Float) {
        self.title = rideTitle
        self.distance = distance
        self.time = time
    }
    
    
    required convenience init(coder aDecoder: NSCoder) {
        let t = aDecoder.decodeObjectForKey("title") as! String
        let d = aDecoder.decodeFloatForKey("distance")
        let ti = aDecoder.decodeFloatForKey("time")
        self.init(rideTitle: t, distance: d, time: ti)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title!, forKey: "title")
        aCoder.encodeFloat(distance!, forKey: "distance")
        aCoder.encodeFloat(time!, forKey: "time")
    }
}