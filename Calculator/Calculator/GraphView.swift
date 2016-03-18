//
//  GraphView.swift
//  Calculator
//
//  Created by Blaise Schaeffer on 3/10/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

protocol GraphViewDataSource: class {
    func retrieveCalculatorBrain(sender: GraphView) -> CalculatorBrain
}

@IBDesignable
class GraphView: UIView {
    
    var axes = AxesDrawer()
    weak var dataSource: GraphViewDataSource?
    
    
    @IBInspectable // Scale of the graph...
    var pointsPerUnit: CGFloat = 20 { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var lineColor: UIColor = UIColor.redColor() { didSet {setNeedsDisplay() }  }
    
    @IBInspectable
    var lineWidth: CGFloat = 2 { didSet {setNeedsDisplay() }  }
    
    
    func scale(gesture: UIPinchGestureRecognizer) {
        if gesture.state == .Changed {
            pointsPerUnit *= gesture.scale
            gesture.scale = 1
        }
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

    
    private var centerOfViewTranslation: CGPoint = CGPoint(x: 0.0, y: 0.0) { didSet { setNeedsDisplay() } }
    
    private var centerOfView: CGPoint {
        return CGPoint(x: convertPoint(center, fromCoordinateSpace: superview!).x + centerOfViewTranslation.x, y: centerOfViewTranslation.y + convertPoint(center, fromCoordinateSpace: superview!).y)
    }

    
    override func drawRect(rect: CGRect) {
        let brain = dataSource?.retrieveCalculatorBrain(self) ?? CalculatorBrain()
        
        let screen: CGRect = UIScreen.mainScreen().bounds
        let width: CGFloat = screen.width;
        let height: CGFloat = screen.height;
        
        let coordinates = getCoordinates(brain, x: width, y: height, scale: pointsPerUnit, origin: centerOfView)
        
        if coordinates != nil {
            let path = UIBezierPath()
            path.lineWidth = lineWidth
            path.moveToPoint(coordinates![0])
            for point in 1..<coordinates!.count {
                let currentPoint = coordinates![point]
                path.addLineToPoint(currentPoint)
                path.moveToPoint(currentPoint)
            }
            lineColor.set()
            path.stroke()
        }
        
        axes.drawAxesInRect(rect, origin: centerOfView, pointsPerUnit: pointsPerUnit)        
    }
    
    
    private func getCoordinates(brain: CalculatorBrain, x: CGFloat, y: CGFloat, scale: CGFloat, origin: CGPoint) -> [CGPoint]? {
        let xLength = x / scale
        let xOriginScale = Double(((origin.x / x)) * xLength)
        
        var xValues = [Double]()
        for x in 0...Int(xLength) {
            if xLength < 75 {
                for decimal in [0.1, 0.2, 0.2, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9] {
                    xValues.append((Double(x) + decimal) - xOriginScale)
                }
            }
            else {
                xValues.append(Double(x) - xOriginScale)
            }
        }
        
        var yValues = [Double?]()
        for x in xValues {
            yValues.append(evaluate(brain, x: x))
            
        }
        
        if yValues[0] != nil {
            let xTranslation = Double(origin.x)
            let yTranslation = Double(origin.y)
            
            var coordinates  = [CGPoint]()
            for x in 0..<xValues.count {
                if yValues[x] != Double.infinity && !yValues[x]!.isNaN {
                    if yValues[x]!.isNormal || yValues[x]!.isZero {
                        let xVal = xValues[x] * Double(scale) + xTranslation
                        let yVal = -1 * yValues[x]! * Double(scale) + yTranslation
                        coordinates.append(CGPoint(x: xVal, y: yVal))
                    }
                }
            }
            return coordinates
        }
        return nil
    }
    
    private func evaluate(brain: CalculatorBrain, x: Double) -> Double? {
        if let val = brain.evaluateForGraphing(x) { return val } else { return nil }
        
    }
}
























