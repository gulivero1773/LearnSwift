import UIKit

enum VendingMachineError: Error {
    case invalideSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}


struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)]
    var coinsDeposited = 0
    
    func vend(itemName name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalideSelection
        }
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
   
        coinsDeposited -= item.price
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
    
    print("\(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels"]


func buyFavoriteSnack(person: String, vedingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy"
    try vendingMachine.vend(itemName: snackName)
}

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8

do {
    try buyFavoriteSnack(person: "Alice", vedingMachine: vendingMachine)
} catch VendingMachineError.invalideSelection {
    print("")
} catch VendingMachineError.outOfStock {
    print("")
} catch VendingMachineError.insufficientFunds(let coinsNeed) {
    print("недос")
}


func someThowingFunc() throws -> Int {
    return 0
}

let x = try? someThowingFunc()

let y: Int?
do {
    y = try someThowingFunc()
} catch {
    y = nil
}


//let photo = try! loadImage(atPath: "l;k")


func processFile(fileName: String) throws {
    if exists(fileName) {
        let file = open(fileName)
        defer {
            close(file)
        }
    }
    while let line = try file.readline() {
        //
    }
    
    // close(file)
}
