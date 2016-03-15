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
//            graphView.addGestureRecognizer(UIPanGestureRecognizer(target: graphView, action: "pan:"))
        }
    }
    
    private func updateUI() {
        graphView?.setNeedsDisplay()
    }
    
}
