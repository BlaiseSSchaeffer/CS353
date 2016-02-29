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
    
    var displayValue: Double? {
        get {
//            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
            if let val =  display.text {
                return NSNumberFormatter().numberFromString(val)!.doubleValue
            } else {
                return nil
            }
        }
        set {
            if newValue == nil {
                display.text = "0.0"
            } else {
                display.text = "\(newValue!)"
            }
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
    

    @IBAction func backspace() {
        if userIsInTheMiddleOfTypingANumber {
            if let length = display.text?.characters.count {
                if length > 1 {
                    display.text = String(display.text!.characters.dropLast())
                } else {
                    display.text = "0.0"
                    userIsInTheMiddleOfTypingANumber = false
                }
            }
        }
    }
    
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue!) {
            displayValue = result
        
            if needCommaSeperator {
                history.text! += ", \(result)"
                print(brain.description)
            } else {
                history.text! += "\(result)"
                print(brain.description)
                needCommaSeperator = true
            }
            
        } else {
            // Make displayValue into an optional, then set it to nil below... How do we do this???
//            displayValue = 0
            displayValue = nil
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        
        if let operation = sender.currentTitle {
            if needCommaSeperator {
                history.text! += ", " + operation + ", ="
                print(brain.description)
            } else {
                history.text! += operation + ", ="
                print(brain.description)
                needCommaSeperator = true
            }
            
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = nil
            }
        }
    }
    
    @IBAction func clear() {
        brain.clear()
        displayValue = nil
        history.text = "Hist: "
        print(brain.description)
        needCommaSeperator = false
    }
}

