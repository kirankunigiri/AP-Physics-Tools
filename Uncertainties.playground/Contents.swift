//: Playground - noun: a place where people can play

import Foundation



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
        let large = (a.num + a.certainty)*(b.num - b.certainty)
        print("Largest result: \(large)")
        print("Largest \\ result = \\frac{\(a.num!)+\(a.certainty!)}{\(b.num!)-\(b.certainty!)}")
        let small = (a.num - a.certainty)*(b.num + b.certainty)
        print("Smallest result: \(small)")
        print("Smallest \\ result = \\frac{\(a.num!)-\(a.certainty!)}{\(b.num!)+\(b.certainty!)}")
        let avgNum = (large + small)/2.0
        print("Average result: \(avgNum)")
        let range = (large - small)
        print("Range: \(range)")
        let result = Uncertain(num: avgNum, certainty: range/2.0)
        print("Result: \(result)")
        return Uncertain(num: avgNum, certainty: range/2.0)
    }
    
    class func divide(_ a: Uncertain, _ b: Uncertain) -> Uncertain {
        let large = (a.num + a.certainty)/(b.num - b.certainty)
        print("Largest result: \(large)")
        let small = (a.num - a.certainty)/(b.num + b.certainty)
        print("Smallest result: \(small)")
        let avgNum = (large + small)/2.0
        print("Average result: \(avgNum)")
        let range = (large - small)
        print("Range: \(range)")
        let result = Uncertain(num: avgNum, certainty: range/2.0)
        print("Result: \(result)")
        return result
    }
    
    public var description: String {
        return "\(num!) +/- \(certainty!)"
    }
    
}


let number1 = Uncertain(num: 1.53, certainty: 0.05)
let number2 = Uncertain(num: 0.67, certainty: 0.02)

print("Addition")
let resultAddition = Uncertain.add(number1, number2)
print("")

print("Subtraction")
let resultSubtraction = Uncertain.subtract(number1, number2)
print("")

print("Multiplication")
let resultMultiplication = Uncertain.multiply(number1, number2)
print("")



