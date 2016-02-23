//
//  DiceModel.swift
//  Dicey
//
//  Created by Blaise Schaeffer on 2/18/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import Foundation

class MSDie {
    var currentValue = 0
    var numSides = 0
    var possibleValues = [String]()
    var frozen = false
    
    init(numSides: Int) {
        srand(42)
        self.numSides = numSides
        currentValue = random() % numSides + 1
    }
    
    convenience init(possibleValues values: [String]) {
        self.init(numSides: values.count)
        self.possibleValues = values
    }
    
    func roll() {
        currentValue = random() % numSides + 1
    }
    
    func getFaceValue() -> Int {
        return currentValue
    }   
    
    func toggleFrozen() {
        if frozen {
            frozen = false
        } else {
            frozen = true
        }
    }
    
    func isFrozen() -> Bool {
        return frozen
    }
}

class Cup {
    var myDice = [MSDie]()
    var possibleValues = [String]()
    
    init(numDice: Int, numSides: Int) {
        for _ in 0..<numDice {
            myDice.append(MSDie(numSides: numSides))
        }
    }
    
    convenience init (withNumDice numDice: Int) {
        self.init(numDice: numDice, numSides: 6)
    }
    
    func roll() -> [Int] {
        var values = [Int]()
        
        for die in myDice {
            if (!die.isFrozen()) {
                die.roll()
                values.append(die.getFaceValue())
            } else {
                values.append(die.getFaceValue())
            }
        }
        return values
    }
    
    func toggleFrozen(idx: Int) {
        myDice[idx].toggleFrozen()
    }
}