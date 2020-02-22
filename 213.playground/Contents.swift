import UIKit

var str = "Hello, playground"

class Human {
var name = "Ivan"
    var age: Int? = 30
    var hairs = true
    
    
    func description() -> String {
        if let humanAge = age {
        return "Hello! My name is \(name) and I'am \(humanAge) years old!"
    }
        else {
            return "Hello "
        }
    }
}

let humanOne = Human()
humanOne.name = "Natasha"
humanOne
humanOne.description()
