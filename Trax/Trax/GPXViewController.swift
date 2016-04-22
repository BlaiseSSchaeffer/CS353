//
//  ViewController.swift
//  Trax
//
//  Created by Blaise Schaeffer on 4/21/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit
import MapKit

class GPXViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.mapType = .Satellite
            mapView.delegate = self
        }
    }
    
    var gpxURL: NSURL? {
        didSet {
            clearWaypoints()
            if let url = gpxURL {
                GPX.parse(url) {
                    if let gpx = $0 {
                        handleWaypoints(gpx.waypoints)
                        
                    }
                }
            }
        }
    }
    
    private func clearWaypoints() {
        if mapView?.annotations != nil { mapView.removeAnnotation(mapView.annotations as [MKAnnotation]) }
    }
    
    private func handleWaypoints(waypoints: [GPX.Waypoint]) {
        mapView.addAnnotation(waypoints)
        mapView.showAnnotations(waypoints, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = NSNotificationCenter.defaultCenter()
        let queue = NSOperationQueue.mainQueue()
        let appDelegate = UIApplication.sharedApplication().delegate
        
        center.addObserverForName(GPXURL.Noritification, object: appDelegate, queue: queue) { notification in
            if let url = notification.userInfo?[GPXURL.Key] as? NSURL {
                
            }
        }
    }
}

