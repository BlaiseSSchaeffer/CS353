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

    
    init(rideTitle: String, distance: Float) {
        self.title = rideTitle
        self.distance = distance
    }
    
//    init(json: [String: AnyObject]) {
//        self.title = json["title"] as? String
//        self.distance = json["distance"] as? Float
//    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let t = aDecoder.decodeObjectForKey("title") as! String
        let d = aDecoder.decodeFloatForKey("distance")
        self.init(rideTitle: t, distance: d)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title!, forKey: "title")
        aCoder.encodeFloat(distance!, forKey: "distance")
    }
}