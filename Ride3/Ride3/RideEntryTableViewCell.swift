//
//  RideEntryTableViewCell.swift
//  Ride3
//
//  Created by Blaise Schaeffer on 4/28/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

func getDocumentsURL() -> NSURL {
    let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
    return documentsURL
}

func fileInDocumentsDirectory(filename: String) -> String {
    
    let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
    return fileURL.path!
    
}

class RideEntryTableViewCell: UITableViewCell {
    var unitOfMeasure = "mi"
    
    var rideEntry: RideEntry?
    var entryIndex: Int?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var rideImageView: UIImageView!
    
    func updateUI() {
        titleLabel.text = rideEntry!.title
        distanceLabel.text = "\(rideEntry!.distance!) \(unitOfMeasure)"
    }
    
    func configure(entryData: RideEntry, index: Int) {
        rideEntry = entryData
        entryIndex = index
        updateUI()
    }
    
    
}