import UIKit


class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil}
        self.name = name
    }
}


class CartItem: Product{
let quantity: Int
init?(name: String, quantity: Int) {
    if quantity < 1 {return nil}
    self.quantity = quantity
    super.init(name:name )
}
}

if let twoSocks = CartItem(name: "носки", quantity: 2) {
    print("Вещь \(twoSocks.name), \(twoSocks.quantity)")
}


if let zeroShirts = CartItem(name: "футболка", quantity: 0) {
    print("Вещь  \(zeroShirts.name) \(zeroShirts.quantity)")
} else {
    print("невозможно инициализировать")
}

if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Вещь \(oneUnnamed.name), \(oneUnnamed.quantity)")
} else {
    print("Невозможно иниа")
}



class Document {
    var name: String?
    init() {}
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}


class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}



class UntitkedDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}



