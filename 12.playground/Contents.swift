import UIKit

let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
print(convertedNumber!)
if convertedNumber != nil {
    print("convertedNumber contains some integer value.")
}
if let actualNumber = Int(possibleNumber) {
    print("\(possibleNumber) has an integer value of \(actualNumber)")
} else {
    print("\(possibleNumber) could not be converted to an integer")
}
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // необходим восклицательный знак

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // восклицательный знак не нужен
if assumedString != nil {
  print(assumedString)
}

let age = -3
assert(age >= 0, "Возраст человека не может быть меньше нуля")
