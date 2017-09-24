//
//  Uncertainties.swift
//  AP Physics Tools
//
//  Created by Kiran Kunigiri on 9/23/17.
//  Copyright © 2017 Kiran Kunigiri. All rights reserved.
//

import Foundation


// MARK: - Uncertain class

/**
 Uncertain
 This class contains a number and its uncertainty. With them, you can
 add, subtract, divide, and multiply uncertain numbers to produce a new
 number with the correct certainty.
 */
class Uncertain: CustomStringConvertible {
    
    var num: Double!
    var uncertainty: Double!
    
    init(num: Double, uncertainty: Double) {
        self.num = num
        self.uncertainty = uncertainty
    }
    
    class func add(_ a: Uncertain, _ b: Uncertain) -> Uncertain {
        let result = Uncertain(num: a.num + b.num, uncertainty: a.uncertainty + b.uncertainty)
        print("$$(\(a)) + (\(b)) = \(result)$$")
        return result
    }
    
    class func subtract(_ a: Uncertain, _ b: Uncertain) -> Uncertain {
        let result = Uncertain(num: a.num - b.num, uncertainty: a.uncertainty + b.uncertainty)
        print("$$(\(a)) - (\(b)) = \(result)$$")
        return result
    }
    
    class func multiply(_ a: Uncertain, _ b: Uncertain) -> Uncertain {
        // Calculations
        var large = (a.num + a.uncertainty)*(b.num + b.uncertainty)
        var small = (a.num - a.uncertainty)*(b.num - b.uncertainty)
        var avgNum = (large + small)/2.0
        var range = (large - small)
        var newUncertainty = range/2.0
        
        // Round numbers for display
        let smallerUncertainty = max(a.uncertainty, b.uncertainty)
        large.round(toPlaces: smallerUncertainty.numberOfDecimals + 2)
        small.round(toPlaces: smallerUncertainty.numberOfDecimals + 2)
        avgNum.round(toPlaces: smallerUncertainty.numberOfDecimals + 2)
        range.round(toPlaces: smallerUncertainty.numberOfDecimals + 2)
        
        // Print latex
        print("$$Expression: (\(a.num!)\\pm\(a.uncertainty!))*(\(b.num!)\\pm\(b.uncertainty!))$$")
        print("$$Largest \\ result = (\(a.num!)+\(a.uncertainty!))*(\(b.num!)+\(b.uncertainty!))=\(large)$$")
        print("$$Smallest \\ result = (\(a.num!)-\(a.uncertainty!))*(\(b.num!)-\(b.uncertainty!))=\(small)$$")
        print("$$Average \\ result = (\(large)+\(small))/(2)=\(avgNum)$$")
        print("$$Range \\ result = \(large)-\(small)=\(range)$$")
        
        // Round result
        avgNum.round(toPlaces: smallerUncertainty.numberOfDecimals)
        range.round(toPlaces: smallerUncertainty.numberOfDecimals)
        newUncertainty.round(toPlaces: smallerUncertainty.numberOfDecimals)
        let result = Uncertain(num: avgNum, uncertainty: newUncertainty)
        
        // Print result
        print("$$Result: \(result)$$")
        
        // Return
        return result
    }
    
    class func divide(_ a: Uncertain, _ b: Uncertain) -> Uncertain {
        var large = (a.num + a.uncertainty)/(b.num - b.uncertainty)
        var small = (a.num - a.uncertainty)/(b.num + b.uncertainty)
        var avgNum = (large + small)/2.0
        var range = (large - small)
        var newUncertainty = range/2.0
        
        // Round numbers for display
        let smallerUncertainty = max(a.uncertainty, b.uncertainty)
        large.round(toPlaces: smallerUncertainty.numberOfDecimals + 2)
        small.round(toPlaces: smallerUncertainty.numberOfDecimals + 2)
        avgNum.round(toPlaces: smallerUncertainty.numberOfDecimals + 2)
        range.round(toPlaces: smallerUncertainty.numberOfDecimals + 2)
        
        // Print latex
        print("$$Expression: \\frac{\(a.num!)\\pm\(a.uncertainty!)}{\(b.num!)\\pm\(b.uncertainty!)}$$")
        print("$$Largest \\ result = \\frac{\(a.num!)+\(a.uncertainty!)}{\(b.num!)-\(b.uncertainty!)}=\(large)$$")
        print("$$Smallest \\ result = \\frac{\(a.num!)-\(a.uncertainty!)}{\(b.num!)+\(b.uncertainty!)}=\(small)$$")
        print("$$Average \\ result = \\frac{\(large)+\(small)}{2}=\(avgNum)$$")
        print("$$Range \\ result = \(large)-\(small)=\(range)$$")
        
        // Round result
        avgNum.round(toPlaces: smallerUncertainty.numberOfDecimals)
        range.round(toPlaces: smallerUncertainty.numberOfDecimals)
        newUncertainty.round(toPlaces: smallerUncertainty.numberOfDecimals)
        let result = Uncertain(num: avgNum, uncertainty: newUncertainty)
        
        // Print result
        print("$$Result: \(result)$$")
        
        // Return
        return result
    }
    
    // Override to string method
    public var description: String {
        return "\(num!) \\pm \(uncertainty!)"
    }
    
}



// MARK: - Decimal Extension
extension Decimal {
    var significantFractionalDecimalDigits: Int {
        return max(-exponent, 0)
    }
}



// MARK: - Double Extension
extension Double {
    
    /** Rounds the double to decimal places value */
//    func rounded(toPlaces places: Int) -> Double {
//        let divisor = pow(10.0, Double(places))
//        return (self * divisor).rounded() / divisor
//    }
    
    /** Rounds a number to the given number of places */
    mutating func round(toPlaces places: Int) {
        let divisor = pow(10.0, Double(places))
        self = (self * divisor).rounded() / divisor
    }
    
    var numberOfDecimals: Int {
        let decimal = Decimal(string: "\(self)")!
        return decimal.significantFractionalDecimalDigits
    }
}



// MARK: - Operator Overloading for the Uncertain class
func +(left: Uncertain, right: Uncertain) -> Uncertain { // 1
    return Uncertain.add(left, right)
}

func -(left: Uncertain, right: Uncertain) -> Uncertain { // 1
    return Uncertain.subtract(left, right)
}


func *(left: Uncertain, right: Uncertain) -> Uncertain { // 1
    return Uncertain.multiply(left, right)
}

func /(left: Uncertain, right: Uncertain) -> Uncertain { // 1
    return Uncertain.divide(left, right)
}



