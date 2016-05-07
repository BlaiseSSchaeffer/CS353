//
//  RideEntryTableViewCell.swift
//  Ride3
//
//  Created by Blaise Schaeffer on 4/28/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

class RideEntryTableViewCell: UITableViewCell {
    var unitOfMeasure = "mi"
    
    var rideEntry: RideEntry?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var rideImageView: UIImageView!
    
    func updateUI() {
        titleLabel.text = rideEntry!.title
        distanceLabel.text = "\(rideEntry!.distance!) \(unitOfMeasure)"
    }
    
    func configure(entryData: RideEntry) {
        rideEntry = entryData
        updateUI()
    }
    
}
