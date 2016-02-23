//
//  ViewController.swift
//  Dicey
//
//  Created by Blaise Schaeffer on 2/16/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var cup = Cup(withNumDice: 5)
    
    @IBOutlet var dice: [UIButton]!
    
    @IBAction func roll() {
        let faceValues = cup.roll()
        
        for (die, value) in zip(dice, faceValues) {
            switch value {
            case 1:
                die.setTitle("⚀", forState: .Normal)
            case 2:
                die.setTitle("⚁", forState: .Normal)
            case 3:
                die.setTitle("⚂", forState: .Normal)
            case 4:
                die.setTitle("⚃", forState: .Normal)
            case 5:
                die.setTitle("⚄", forState: .Normal)
            case 6:
                die.setTitle("⚅", forState: .Normal)
            default:
                break
            }
        }
    }
    
    
    @IBAction func freeze(sender: UIButton) {
        if sender.titleLabel!.textColor == UIColor.redColor() {
            sender.setTitleColor(UIColor(red:255.0/255.0, green:206.0/255.0, blue:101.0/255.0, alpha: 1.0), forState: .Normal)
        } else {
            sender.setTitleColor(UIColor.redColor(), forState: .Normal)
        }
        cup.toggleFrozen(sender.tag)
    }

}

