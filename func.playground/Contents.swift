import UIKit

var str = "Hello, playground"
func returnValue() -> Int {
    let c = 10
    return c
    
}
let a = returnValue()
a

func giveMeYour(name: String, andSecondName: String)-> String {
    return "Your full name is \(name) \(andSecondName)"
    
    
}

giveMeYour(name: "Ivan", andSecondName: "Akulov")

print(giveMeYour(name: "String", andSecondName: " "))
