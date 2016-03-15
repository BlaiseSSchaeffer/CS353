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
    var origin: CGPoint {
        return convertPoint(center, fromCoordinateSpace: superview!)
    }
    
    @IBInspectable
    var pointsPerUnit: CGFloat = 10 { didSet { setNeedsDisplay() } }
        
    
    func scale(gesture: UIPinchGestureRecognizer) {
        if gesture.state == .Changed {
            pointsPerUnit *= gesture.scale
            gesture.scale = 1
        }
    }
    
//    func pan(gesture: UIPanGestureRecognizer) {
//        switch gesture.state {
//        case .Ended: fallthrough
//        case .Changed:
//            let translation = gesture.translationInView(self)
//            let panChange = -Int(translation.y / 4)
//            if panChange != 0 {
//                gesture.setTranslation(origin, inView: self)
//            }
//        default: break
//        }
//    }
    
    override func drawRect(rect: CGRect) {
        axes.drawAxesInRect(rect, origin: origin, pointsPerUnit: pointsPerUnit)
    }
}
