//
//  ViewController.swift
//  Cassini
//
//  Created by Blaise Schaeffer on 3/29/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let ivc = segue.destinationViewController as? ImageViewController {
            if let identifier = segue.identifier {
                switch identifier {
                    case "Earth":
                        ivc.imageURL = DemoURL.NASA.Earth
                        ivc.title = "Eatrh"
                    case "Saturn":
                        ivc.imageURL = DemoURL.NASA.Saturn
                        ivc.title = "Saturn"
                    case "Stanford":
                        ivc.imageURL = DemoURL.Stanford
                        ivc.title = "Stanford"
                    case "Cassini":
                        ivc.imageURL = DemoURL.NASA.Cassini
                        ivc.title = "Cassini"
                default: break
                }
            }
        }
    }

}

