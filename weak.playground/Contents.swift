import UIKit


class Customer {
    let name: String
    var card: CreditCard?
    init(name:String) {
        self.name = name
    }
    deinit {
print("\(name) деинициализация")
    }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("Карта номер \(number)")
    }
}


var john: Customer?

john = Customer(name: "John")
john?.card = CreditCard(number: 1234567890123456, customer: john!)

john = nil
