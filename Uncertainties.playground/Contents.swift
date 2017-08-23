//: Playground - noun: a place where people can play

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
    var certainty: Double!
    
    init(num: Double, certainty: Double) {
        self.num = num
        self.certainty = certainty
    }
    
    class func add(_ a: Uncertain, _ b: Uncertain) -> Uncertain {
        let result = Uncertain(num: a.num + b.num, certainty: a.certainty + b.certainty)
        print(result)
        return result
    }
    
    class func subtract(_ a: Uncertain, _ b: Uncertain) -> Uncertain {
        let result = Uncertain(num: a.num - b.num, certainty: a.certainty + b.certainty)
        print(result)
        return result
    }
    
    class func multiply(_ a: Uncertain, _ b: Uncertain) -> Uncertain {
        // Calculations
        let large = (a.num + a.certainty)*(b.num - b.certainty)
        let small = (a.num - a.certainty)*(b.num + b.certainty)
        let avgNum = (large + small)/2.0
        let range = (large - small)
        let result = Uncertain(num: avgNum, certainty: range/2.0)
        
        // Print output
        print("Calculations")
        print("Largest result: \(large)")
        print("Smallest result: \(small)")
        print("Average result: \(avgNum)")
        print("Range: \(range)")
        print("Result: \(result)")
        print("")
        
        // Print latex
        print("LATEX Output")
        print("$$Expression: (\(a.num!)\\pm\(a.certainty!))*(\(b.num!)\\pm\(b.certainty!))$$")
        print("$$Largest \\ result = (\(a.num!)+\(a.certainty!))*(\(b.num!)-\(b.certainty!))=\(large)$$")
        print("$$Smallest \\ result = (\(a.num!)-\(a.certainty!))*(\(b.num!)+\(b.certainty!))=\(small)$$")
        print("$$Average \\ result = (\(large)+\(small))/(2)=\(avgNum)$$")
        print("$$Range \\ result = \(large)-\(small)=\(range)$$")
        print("$$Result: \(result)$$")
        
        // Return
        return Uncertain(num: avgNum, certainty: range/2.0)
    }
    
    class func divide(_ a: Uncertain, _ b: Uncertain) -> Uncertain {
        let large = (a.num + a.certainty)/(b.num - b.certainty)
        let small = (a.num - a.certainty)/(b.num + b.certainty)
        let avgNum = (large + small)/2.0
        let range = (large - small)
        let result = Uncertain(num: avgNum, certainty: range/2.0)
        
        // Print output
        print("Calculations")
        print("Largest result: \(large)")
        print("Smallest result: \(small)")
        print("Average result: \(avgNum)")
        print("Range: \(range)")
        print("Result: \(result)")
        print("")
        
        // Print latex
        print("LATEX Output")
        print("$$Expression: \\frac{\(a.num!)\\pm\(a.certainty!)}{\(b.num!)\\pm\(b.certainty!)}$$")
        print("$$Largest \\ result = \\frac{\(a.num!)+\(a.certainty!)}{\(b.num!)-\(b.certainty!)}=\(large)$$")
        print("$$Smallest \\ result = \\frac{\(a.num!)-\(a.certainty!)}{\(b.num!)+\(b.certainty!)}=\(small)$$")
        print("$$Average \\ result = \\frac{\(large)+\(small)}{2}=\(avgNum)$$")
        print("$$Range \\ result = \(large)-\(small)=\(range)$$")
        print("$$Result: \(result)$$")
        
        // Return
        return Uncertain(num: avgNum, certainty: range/2.0)
    }
    
    // Override to string method
    public var description: String {
        return "\(num!) \\pm \(certainty!)"
    }
    
    // TODO: Override operators
    
    // TODO: Round results based on number of digits in number and uncertainty (highest number of digits) 
    
}



// MARK: - Tests
let number1 = Uncertain(num: 1.53, certainty: 0.05)
let number2 = Uncertain(num: 0.67, certainty: 0.02)

print("Addition")
let resultAddition = Uncertain.add(number1, number2)
print("")

print("Subtraction")
let resultSubtraction = Uncertain.subtract(number1, number2)
print("")

print("\nMultiplication\n")
let resultMultiplication = Uncertain.multiply(number1, number2)
print("")

print("\nDivision\n")
let resultDivision = Uncertain.divide(number1, number2)
print("")



