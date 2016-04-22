//
//  ViewController.swift
//  Bouncer
//
//  Created by Blaise Schaeffer on 4/21/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Top level view is uaually not for this kind of thing, it is for subviews!!!
    let bouncer = BouncerBehavior()
    lazy var animator: UIDynamicAnimator = { UIDynamicAnimator(referenceView: self.view) }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(bouncer)
    }

    struct Constants {
        static let BlockSize = CGSize(width: 40, height: 40)
    }
    
    var redBlock: UIView?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if redBlock == nil {
            redBlock = addBlock()
            redBlock?.backgroundColor = UIColor.redColor()
            bouncer.addBlock(redBlock!)
        }
        let motionManager = AppDelegate.Motion.Manager
        if motionManager.accelerometerAvailable {
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) { (data, error) -> Void in
                self.bouncer.gravity.gravityDirection = CGVector(dx: (data?.acceleration.x)!, dy: -(data?.acceleration.y)!)
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        AppDelegate.Motion.Manager.stopAccelerometerUpdates()
    }
    
    func addBlock() -> UIView {
        let block = UIView(frame: CGRect(origin: CGPoint.zero, size: Constants.BlockSize))
        block.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        view.addSubview(block)
        return block
    }
}

