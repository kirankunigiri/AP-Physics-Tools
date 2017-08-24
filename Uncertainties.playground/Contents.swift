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
        var newNum = Uncertain(num: avgNum, uncertainty: newUncertainty)
        
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
        return newNum
    }
    
    class func divide(_ a: Uncertain, _ b: Uncertain) -> Uncertain {
        var large = (a.num + a.uncertainty)/(b.num - b.uncertainty)
        var small = (a.num - a.uncertainty)/(b.num + b.uncertainty)
        var avgNum = (large + small)/2.0
        var range = (large - small)
        var newUncertainty = range/2.0
        var newNum = Uncertain(num: avgNum, uncertainty: newUncertainty)
        
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
        return newNum
    }
    
    // Override to string method
    public var description: String {
        return "\(num!) \\pm \(uncertainty!)"
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
let number1 = Uncertain(num: 1.53, uncertainty: 0.05)
let number2 = Uncertain(num: 0.67, uncertainty: 0.02)

print("Addition")
let resultAddition = number1 + number2
print("")

print("Subtraction")
let resultSubtraction = number1 - number2
print("")

print("Multiplication")
let resultMultiplication = number1 * number2
print("")

print("Division")
let resultDivision2 = number1/number2
print("")



