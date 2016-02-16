//
//  ViewController.swift
//  Calculator
//
//  Created by Blaise Schaeffer on 2/4/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    var needCommaSeperator = false
    var brain = CalculatorBrain()
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
            
            if needCommaSeperator {
                history.text! += ", \(result)"
            } else {
                history.text! += "\(result)"
                needCommaSeperator = true
            }
            
        } else {
            // Make displayValue into an optional, then set it to nil below... How do we do this???
            displayValue = 0
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        
        if let operation = sender.currentTitle {
            if needCommaSeperator {
                history.text! += ", " + operation
            } else {
                history.text! += operation
                needCommaSeperator = true
            }
            
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func clear() {
        brain.clear()
        displayValue = 0
        history.text = "Hist: "
        needCommaSeperator = false
    }
}

