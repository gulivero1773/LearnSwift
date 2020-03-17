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
        "chips": Item(price: 10, count: 4),
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
    try vendingMachine.vend(itemNamed: snackName)
}








