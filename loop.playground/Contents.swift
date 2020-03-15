import UIKit

class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
    var apartment: Apartment?
    deinit {
        print("\(name) освобождается")
    }
}

class Apartment {
    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    var tenant: Person?
    deinit {
        print("Апартаменты \(unit) освобождаються")
    }
}


var john: Person?
var unit4a: Apartment?

john = Person(name: "John Appleseed")
unit4a = Apartment(unit: "4a")

john!.apartment = unit4a
unit4a!.tenant = john

john = nil
unit4a = nil

















