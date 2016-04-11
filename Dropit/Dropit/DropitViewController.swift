//
//  DropitViewController.swift
//  Dropit
//
//  Created by Blaise Schaeffer on 4/9/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

class DropitViewController: UIViewController, UIDynamicAnimatorDelegate {
    
    @IBOutlet weak var gameView: BezierPathsView!

    
    lazy var animator: UIDynamicAnimator = {
        let lazilyCreatedDynamicAnimator = UIDynamicAnimator(referenceView: self.gameView)
        lazilyCreatedDynamicAnimator.delegate = self
        return lazilyCreatedDynamicAnimator
        
    }()
    
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        removeCompletedRow()
    }
    
    let dropitBehavior = DropitBehavior()
    
    var attatchment: UIAttachmentBehavior? {
        willSet {
            if let theAttatchment = attatchment {
                animator.removeBehavior(theAttatchment)
                gameView.setPath(nil, named: PathNames.Attatchment)
            }
        }
        didSet {
            if attatchment != nil {
                animator.addBehavior(attatchment!)
                attatchment?.action = { [unowned self] in
                    if let attatchedView = self.attatchment?.items.first as? UIView {
                        let path = UIBezierPath()
                        path.moveToPoint(self.attatchment!.anchorPoint)
                        path.addLineToPoint(attatchedView.center)
                        self.gameView.setPath(path, named: PathNames.Attatchment)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(dropitBehavior)
    }
    
    struct PathNames {
        static let MiddleBarrier = "Middle Barrier"
        static let Attatchment = "Attatchment"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let barrierSize = dropSize
        let barrierOrigin = CGPoint(x: gameView.bounds.midX-barrierSize.width/2, y: gameView.bounds.midY-barrierSize.height/2)
        let path = UIBezierPath(ovalInRect: CGRect(origin: barrierOrigin, size: barrierSize))
        dropitBehavior.addBarrier(path, named: PathNames.MiddleBarrier)
        gameView.setPath(path, named: PathNames.MiddleBarrier)
        
    }
    
    var dropsPerRow = 10
    var dropSize: CGSize {
        let size = gameView.bounds.size.width / CGFloat(dropsPerRow)
        return CGSize(width: size, height: size)
    }
    
    @IBAction func drop(sender: UIGestureRecognizer) {
        drop()
    }
    
    var lastDroppedView: UIView?
    
    @IBAction func grabDrop(sender: UIPanGestureRecognizer) {
        let gesturePoint = sender.locationInView(gameView)
        
        switch sender.state {
        case .Began:
            if let viewToAttatchTo = lastDroppedView {
                attatchment = UIAttachmentBehavior(item: viewToAttatchTo, attachedToAnchor: gesturePoint)
                lastDroppedView = nil
            }
        case .Changed:
            attatchment?.anchorPoint = gesturePoint
        case .Ended:
            attatchment = nil
        default: break
        }
    }
    
    func drop() {
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x = CGFloat.random(dropsPerRow) * dropSize.width
        
        let dropView = UIView(frame: frame)
        dropView.backgroundColor = UIColor.random
        
        lastDroppedView = dropView
        
        dropitBehavior.addDrop(dropView)
    }
    
    func removeCompletedRow() {
        var dropsToRemove = [UIView]()
        var dropFrame = CGRect(x:0, y: gameView.frame.maxY, width: dropSize.width, height: dropSize.height)
        
        repeat {
            dropFrame.origin.y -= dropSize.height
            dropFrame.origin.x = 0
            var dropsFound = [UIView]()
            var rowIsComplete = true
            for _ in 0 ..< dropsPerRow {
                if let hitView = gameView.hitTest(CGPoint(x: dropFrame.midX, y: dropFrame.midY), withEvent: nil) {
                    if hitView.superview == gameView {
                        dropsFound.append(hitView)
                    } else {
                        rowIsComplete = false
                    }
                }
                dropFrame.origin.x += dropSize.width
            }
            if rowIsComplete {
                dropsToRemove += dropsFound
            }
        } while dropsToRemove.count == 0 && dropFrame.origin.y > 0
        
        for drop in dropsToRemove {
            dropitBehavior.removeDrop(drop)
        }
    }
    
}

private extension CGFloat {
    static func random(max: Int) -> CGFloat {
        return CGFloat(arc4random() % UInt32(max))
    }
}


private extension UIColor {
    class var random: UIColor {
        switch arc4random()%5 {
        case 0: return UIColor.greenColor()
        case 1: return UIColor.blueColor()
        case 2: return UIColor.orangeColor()
        case 3: return UIColor.redColor()
        case 4: return UIColor.purpleColor()
        default: return UIColor.blackColor()
        }
    }
}



