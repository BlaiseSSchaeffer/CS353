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
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var rideImageView: UIImageView?
    
//    override func viewWillAppear(animated: Bool) {
//        distanceLabel.layer.cornerRadius = 5
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        distanceLabel.layer.cornerRadius = 2
        updateUI()
    }
    
    func updateUI() {
        self.title = rideEntry!.title
        distanceLabel.text = "\(rideEntry!.distance!) mi"
        
        if (image != nil) {
            rideImageView?.image = image
        }
    }

}
