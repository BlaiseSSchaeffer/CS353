//
//  GraphView.swift
//  Calculator
//
//  Created by Blaise Schaeffer on 3/10/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

@IBDesignable
class GraphView: UIView {
    
    var axes = AxesDrawer()
    
    @IBInspectable
    var pointsPerUnit: CGFloat = 20 { didSet { setNeedsDisplay() } }
    
    
    func scale(gesture: UIPinchGestureRecognizer) {
        if gesture.state == .Changed {
            pointsPerUnit *= gesture.scale
            gesture.scale = 1
        }
    }

    
    @IBInspectable
    var centerOfViewTranslation: CGPoint = CGPoint(x: 0.0, y: 0.0) { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var centerOfView: CGPoint {
        return CGPoint(x: convertPoint(center, fromCoordinateSpace: superview!).x + centerOfViewTranslation.x, y: centerOfViewTranslation.y + convertPoint(center, fromCoordinateSpace: superview!).y)
    }
    
    func pan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(self)
            centerOfViewTranslation.x += translation.x
            centerOfViewTranslation.y += translation.y
            gesture.setTranslation(CGPointZero, inView: self)
        default: break
        }
    }
    
    func recenter(gesture: UITapGestureRecognizer) {
        gesture.numberOfTapsRequired = 2
        if gesture.state == .Ended {
            centerOfViewTranslation = CGPoint(x: 0.0, y: 0.0)
        }
    }
    
    override func drawRect(rect: CGRect) {
        axes.drawAxesInRect(rect, origin: centerOfView, pointsPerUnit: pointsPerUnit)
    }
}
























