//: Playground - noun: a place where people can play

import Foundation



extension Decimal {
    var significantFractionalDecimalDigits: Int {
        return max(-exponent, 0)
    }
}


extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    mutating func round(toPlaces places: Int) {
        let divisor = pow(10.0, Double(places))
        self = (self * divisor).rounded() / divisor
    }
    var numberOfDecimals: Int {
        let decimal = Decimal(string: "\(self)")!
        return decimal.significantFractionalDecimalDigits
    }
}


// MARK: - Uncertain class

/**
 Uncertain
 This class contains a number and its uncertainty. With them, you can 
 add, subtract, divide, and multiply uncertain numbers to produce a new
 number with the correct certainty.
 */
class Uncertain: CustomStringConvertible {
    
    var num: Double!
    var certainty: Double!
    
    init(num: Double, certainty: Double) {
        self.num = num
        self.certainty = certainty
    }
    
    class func add(_ a: Uncertain, _ b: Uncertain) -> Uncertain {
        let result = Uncertain(num: a.num + b.num, certainty: a.certainty + b.certainty)
        print("$$(\(a)) + (\(b)) = \(result)$$")
        return result
    }
    
    class func subtract(_ a: Uncertain, _ b: Uncertain) -> Uncertain {
        let result = Uncertain(num: a.num - b.num, certainty: a.certainty + b.certainty)
        print("$$(\(a)) - (\(b)) = \(result)$$")
        return result
    }
    
    class func multiply(_ a: Uncertain, _ b: Uncertain) -> Uncertain {
        // Calculations
        var large = (a.num + a.certainty)*(b.num + b.certainty)
        var small = (a.num - a.certainty)*(b.num - b.certainty)
        var avgNum = (large + small)/2.0
        var range = (large - small)
        var uncertainty = range/2.0
        
        // Round numbers for display
        let smallerUncertainty = max(a.certainty, b.certainty)
        large.round(toPlaces: smallerUncertainty.numberOfDecimals + 2)
        small.round(toPlaces: smallerUncertainty.numberOfDecimals + 2)
        avgNum.round(toPlaces: smallerUncertainty.numberOfDecimals + 2)
        range.round(toPlaces: smallerUncertainty.numberOfDecimals + 2)
        
        // Print latex
        print("$$Expression: (\(a.num!)\\pm\(a.certainty!))*(\(b.num!)\\pm\(b.certainty!))$$")
        print("$$Largest \\ result = (\(a.num!)+\(a.certainty!))*(\(b.num!)+\(b.certainty!))=\(large)$$")
        print("$$Smallest \\ result = (\(a.num!)-\(a.certainty!))*(\(b.num!)-\(b.certainty!))=\(small)$$")
        print("$$Average \\ result = (\(large)+\(small))/(2)=\(avgNum)$$")
        print("$$Range \\ result = \(large)-\(small)=\(range)$$")
        
        // Round result
        avgNum.round(toPlaces: smallerUncertainty.numberOfDecimals)
        range.round(toPlaces: smallerUncertainty.numberOfDecimals)
        uncertainty.round(toPlaces: smallerUncertainty.numberOfDecimals)
        let result = Uncertain(num: avgNum, certainty: uncertainty)
        
        // Print result
        print("$$Result: \(result)$$")
        
        // Return
        return Uncertain(num: avgNum, certainty: range/2.0)
    }
    
    class func divide(_ a: Uncertain, _ b: Uncertain) -> Uncertain {
        var large = (a.num + a.certainty)/(b.num - b.certainty)
        var small = (a.num - a.certainty)/(b.num + b.certainty)
        var avgNum = (large + small)/2.0
        var range = (large - small)
        var uncertainty = range/2.0
        
        // Round numbers for display
        let smallerUncertainty = max(a.certainty, b.certainty)
        large.round(toPlaces: smallerUncertainty.numberOfDecimals + 2)
        small.round(toPlaces: smallerUncertainty.numberOfDecimals + 2)
        avgNum.round(toPlaces: smallerUncertainty.numberOfDecimals + 2)
        range.round(toPlaces: smallerUncertainty.numberOfDecimals + 2)
        
        // Print latex
        print("$$Expression: \\frac{\(a.num!)\\pm\(a.certainty!)}{\(b.num!)\\pm\(b.certainty!)}$$")
        print("$$Largest \\ result = \\frac{\(a.num!)+\(a.certainty!)}{\(b.num!)-\(b.certainty!)}=\(large)$$")
        print("$$Smallest \\ result = \\frac{\(a.num!)-\(a.certainty!)}{\(b.num!)+\(b.certainty!)}=\(small)$$")
        print("$$Average \\ result = \\frac{\(large)+\(small)}{2}=\(avgNum)$$")
        print("$$Range \\ result = \(large)-\(small)=\(range)$$")
        
        // Round result
        avgNum.round(toPlaces: smallerUncertainty.numberOfDecimals)
        range.round(toPlaces: smallerUncertainty.numberOfDecimals)
        uncertainty.round(toPlaces: smallerUncertainty.numberOfDecimals)
        let result = Uncertain(num: avgNum, certainty: uncertainty)
        
        // Print result
        print("$$Result: \(result)$$")
        
        // Return
        return Uncertain(num: avgNum, certainty: range/2.0)
    }
    
    // Override to string method
    public var description: String {
        return "\(num!) \\pm \(certainty!)"
    }
    
}



// MARK: - Operator Overloading for Uncertain
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



// MARK: - Tests
let number1 = Uncertain(num: 1.53, certainty: 0.05)
let number2 = Uncertain(num: 0.67, certainty: 0.02)

print("Addition")
let resultAddition2 = number1 + number2
print("")

print("Subtraction")
let resultSubtraction2 = number1 - number2
print("")

print("Multiplication")
let resultMultiplication2 = number1 * number2
print("")

print("Division")
let resultDivision2 = number1/number2
print("")



