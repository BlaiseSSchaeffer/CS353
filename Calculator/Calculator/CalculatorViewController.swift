//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Blaise Schaeffer on 2/4/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

//protocol CalculatorViewDataSource: class {
//    func equationForCalculatorView(sender: CalculatorViewController) -> String?
//}


class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    
    var userIsInTheMiddleOfTypingANumber = false
    var brain = CalculatorBrain()
    
    var displayValue: Double? {
        get {
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
        displayValue = brain.pushOperand(displayValue!)
        history.text = brain.description
    }
    
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        
        if let operation = sender.currentTitle {
            displayValue = brain.performOperation(operation)
            history.text = brain.description
        }
    }
    
    
    @IBAction func clear() {
        brain.clear()
        brain.variableValues = [String:Double]()
        displayValue = nil
        history.text = "History"
    }
    
    
    @IBAction func saveToMemory() {
        if let num = displayValue {
            brain.variableValues["M"] = num
            userIsInTheMiddleOfTypingANumber = false
            displayValue = brain.evaluate()
        }
    }
    
    
    @IBAction func retrieveFromMemory() {
        brain.pushOperand("M")
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        var destination = segue.destinationViewController as  UIViewController
        
        if let navCon = destination as? UINavigationController {
            
            destination = navCon.visibleViewController!
        }
        if let gvc = destination as? GraphViewController {
            if let identifier = segue.identifier {
                let hist = history.text!.componentsSeparatedByString(", ")
                var equation = hist.last
                if equation == "History" {
                    equation = "Graph"
                }
            
                switch identifier {
                    case "graph":
                    gvc.equation = equation!
                    gvc.brain = brain
                    
                default:
                    gvc.equation = equation!
                    gvc.brain = brain
                }
            }
        }
    }
    
}




