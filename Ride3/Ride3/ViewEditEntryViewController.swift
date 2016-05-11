//
//  ViewEditEntryViewController.swift
//  Ride3
//
//  Created by Blaise Schaeffer on 4/30/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit
import QuartzCore

class ViewEditEntryViewController: UIViewController {
    
    var rideEntry: RideEntry?
    var image: UIImage?
    var entryIndex: Int?
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var rideImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        distanceLabel.layer.cornerRadius = 2
        updateUI()
    }
    
    func updateUI() {
        self.title = rideEntry!.title
        distanceLabel.text = "\(rideEntry!.distance!) mi"
        timeLabel.text = "\(rideEntry!.time!) hours"
        
        if (image != nil) {
            rideImageView?.image = image
        }
    }
    
    func editEntry() {

    }

}
