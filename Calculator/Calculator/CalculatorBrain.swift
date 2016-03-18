//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Blaise Schaeffer on 2/6/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import Foundation

class CalculatorBrain {
    var description: String {
        var result = postfixToInfix(opStack)
        var desc = result.desc
        var remainingOps = result.remainingOps
        while !remainingOps.isEmpty {
            result = postfixToInfix(remainingOps)
            desc = result.desc + ", " + desc
            remainingOps = result.remainingOps
        }
        return desc + " ="
    }
    
    
    private func postfixToInfix(ops: [Op]) -> (desc: String, remainingOps: [Op]) {
        if !ops.isEmpty {
            var remaimingOps = ops
            let op = remaimingOps.removeLast()
            
            switch op {
            case.Operand(let operand):
                return ("\(operand)", remaimingOps)
                
            case.UnaryOperation(let operation, _):
                let postfixToInFixEvaluation = postfixToInfix(remaimingOps)
                let operand = postfixToInFixEvaluation.desc
                return("\(operation)(\(operand))", postfixToInFixEvaluation.remainingOps)
                
            case.BinaryOperation(let operation, _):
                let pti1 = postfixToInfix(remaimingOps)
                let operand1 = pti1.desc
                let pti2 = postfixToInfix(pti1.remainingOps)
                let operand2 = pti2.desc
                return ("(\(operand2) \(operation) \(operand1))", pti2.remainingOps)
    
            case.ConstantOperation(let constant, _):
                return ("\(constant)", remaimingOps)
                
            case .Variable(let variable):
                return (variable, remaimingOps)
            }
        }
        return ("?", ops)
    }
    
    
    private enum Op: CustomStringConvertible {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        case ConstantOperation(String, Double)
        case Variable(String)
        
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                case .ConstantOperation(let constant, _):
                    return constant
                case .Variable(let variable):
                    return "\(variable)"
                }
            }
        }
        
    }
    
    
    private var opStack = [Op]()
    private var knownOps = [String:Op]()
    var variableValues = [String:Double]()
    
    
    init() {
        func learnOp(op: Op) {
            knownOps[op.description] = op
        }
        
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("÷") { $1 / $0 })
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("−") { $1 - $0 })
        learnOp(Op.UnaryOperation("√", sqrt))
        learnOp(Op.UnaryOperation("sin", sin))
        learnOp(Op.UnaryOperation("cos", cos))
        learnOp(Op.UnaryOperation("%", { (num) -> Double in return num / 100 }))
        learnOp(Op.UnaryOperation("ᐩ/-", { (num) -> Double in return num * -1 }))
        learnOp(Op.UnaryOperation("1/x", { (num) -> Double in return 1 / num }))
        learnOp(Op.UnaryOperation(("10^x"), { (num) -> Double in return pow(10, num) }))
        learnOp(Op.UnaryOperation(("x^2"), { (num) -> Double in return pow(num, 2) }))
        learnOp(Op.ConstantOperation("π", M_PI))
        learnOp(Op.ConstantOperation("e", M_E))
    }
    
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    
    func pushOperand(symbol: String) -> Double? {
        opStack.append(Op.Variable(symbol))
        return evaluate()
    }
    
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
    
    
    typealias PropertyList = AnyObject
    var program: PropertyList { // Guaranteed to be a PropetryList -- ONLY THING THAT NEEDS WORK...
        get { return opStack.map { $0.description } }
        
        set {
            if let opSymbols = newValue as? [String] {
                var newOpStack = [Op]()
                for opSymbol in opSymbols {
                    if let op = knownOps[opSymbol] {
                        newOpStack.append(op)
                    } else if let operand =  NSNumberFormatter().numberFromString(opSymbol)?.doubleValue {
                        newOpStack.append(.Operand(operand))
                    }
                }
                opStack = newOpStack
            }
        }
    }
    
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
                
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
                
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
                
            case .ConstantOperation(_, let constant):
                return (constant, remainingOps)
                
            case .Variable(let variable):
                if let value = variableValues[variable] {
                    return (value, remainingOps)
                } else {
                    return (nil, remainingOps)
                }
            }
        }
        return (nil, ops)
    }
    
    
    func evaluate() -> Double? {
        let (result, _) = evaluate(opStack)
//        print("\(opStack) = \(result) with \(remainder) left over.")
        return result
    }
    
    
    private func evaluateForGraphing(ops: [Op], x: Double) -> (result: Double?, remainingOps: [Op]) {
        
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
                
            case .UnaryOperation(_, let operation):
                
                let operandEvaluation = evaluateForGraphing(remainingOps, x:x)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
                
                
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluateForGraphing(remainingOps, x:x)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluateForGraphing(op1Evaluation.remainingOps, x:x)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1,operand2), op2Evaluation.remainingOps)
                    }
                }
            case .Variable(_):
                return (x, remainingOps)
                
            case .ConstantOperation(_, let constant):
                return (constant, remainingOps)
            }
        }
        return (nil,ops)
    }
    
    
    func evaluateForGraphing(x:Double) -> Double? {
        let (result, _) = evaluateForGraphing(opStack,x:x)
        return result
    }
    
    
    func clear() {
        opStack.removeAll()
    }
}




