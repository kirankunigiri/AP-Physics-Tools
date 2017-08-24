# AP Physics Tools
A collection of tools created to automate tasks for the AP Physics class (specifically at Cupertino High School).

## About

More tools will be created and added as the year goes on. All of the tools are currently written in Swift. They will probably be ported over to Java as well later on. Keep in mind that these tools are fairly simple and are meant for automating calculations and producing latex equations.

## Tools
1. Uncertainty Calculator

## Documentation
### Uncertainty Calculations
This tool automatically calculates operations with uncertain numbers, and gives you the result with the new uncertainty value. Addition, subtraction, multiplication, and division are all supported.

The following is an example.

``` swift
// Create two uncertain numbers
let number1 = Uncertain(num: 1.53, uncertainty: 0.05)
let number2 = Uncertain(num: 0.67, uncertainty: 0.02)

// Operations
let resultAddition = number1 + number2
let resultSubtraction = number1 - number2
let resultMultiplication = number1 * number2
let resultDivision = number1/number2
```

With those calculations, you would get the following as output (as latex). To use this in Google Docs, get the [auto latex extension](https://chrome.google.com/webstore/detail/auto-latex-equations/iaainhiejkciadlhlodaajgbffkebdog) and you can convert the output into these beautiful equations!
![Demo](Assets/UncertainDemo.png)