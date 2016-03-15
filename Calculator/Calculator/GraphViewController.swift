//
//  GraphViewController.swift
//  Calculator
//
//  Created by Blaise Schaeffer on 3/10/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {

    @IBOutlet weak var graphView: GraphView! {
        didSet {
            graphView.addGestureRecognizer(UIPinchGestureRecognizer(target: graphView, action: "scale:"))
            graphView.addGestureRecognizer(UIPanGestureRecognizer(target: graphView, action: "pan:"))
            graphView.addGestureRecognizer(UITapGestureRecognizer(target: graphView, action: "recenter:"))
        }
    }
    
    private func updateUI() {
        graphView?.setNeedsDisplay()
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        updateUI()
    }
    
}



//  xMax - xMin = ? (20)
//  200/20 = 10
// Graph (-3,-2) and (5,7)
// * scaling factor (10) ---> (-30,-20) and (50,70)
// scren translation...
//      width/2 = 100 and height/2 = 100
// -30 + 100 = screen coordinate 70 for x
// -20 * -1 = 20 + 100 = 120 for screen cordinate for y
//
// Scale from workd cordinates and then translate them
//
//
// 300 / 30  = 10 scaling
// 300 / 2 = 150
// 10 * 10 = 100 + 150 = 250
// -5 * 10 = -50 * -1 = 50 + 150 = 200
// (250, 200)


// Pinching changes scale factor
// Panning changes an offset from the origin...
