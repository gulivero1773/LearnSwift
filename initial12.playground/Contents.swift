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


class SomeClass {
    required init() {
        
    }
}

class SomeSubClass: SomeClass {
    var name: String = ""
    init(name: String) {
        self.name = name
    }
    required init() {
            self.name = "XXX"
        }
    }


//class SomeNewClass {
//    let someProperty: SomeType = {
//        //
//        return someValue
//    } ()
//}


struct Chessboard {
    let boardColors: [Bool] = {
       var tempBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                tempBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return tempBoard
    }()
    func squareIsBlackAt(row: Int, colum: Int) -> Bool {
        return boardColors[(row * 8) + colum]
    }
}

let board = Chessboard()
print(board.squareIsBlackAt(row: 0, colum: 1))
print(board.squareIsBlackAt(row: 7, colum: 7))




class Bank {
    static var coinsInBank = 10000
    static func distibute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distibute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distibute(coins: coins)
    }
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}


var playerOne: Player? = Player(coins: 100)
print("\(playerOne!.coinsInPurse)")
print("\(Bank.coinsInBank)")

playerOne = nil
print("")
print("\(Bank.coinsInBank)")
