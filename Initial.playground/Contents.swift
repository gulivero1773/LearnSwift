import UIKit


class Vehicle {
    var numberOfWheels = 0
    var deskription: String {
        return "\(numberOfWheels)"
    }
}
let vehicle = Vehicle()
print("\(vehicle.deskription)")


class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
print("\(bicycle.numberOfWheels)")


class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Без названия]")
    }
}

let nameMeat = Food(name: "Бекон")
nameMeat.name

let mysteryMeat = Food()
mysteryMeat.name

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name:name, quantity: 1)
        }
    }
    

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Бекон")
oneBacon.name
oneBacon.quantity

let sixEggs = RecipeIngredient(name: "Яйца", quantity: 6)
sixEggs.name
sixEggs.quantity


class ShopingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✓" : " ✗"
        return output
    }
}

var breakfastList = [
ShopingListItem(),
ShopingListItem(name: "Бекон"),
ShopingListItem(name: "Яйца", quantity: 6)]


breakfastList[0].name = "Сок"
breakfastList[0].purchased = true

for item in breakfastList {
    print(item.description)
}

let mayBeNumber = "123"
if let number = Int(mayBeNumber) {
    print("\(mayBeNumber) \(number)")
} else {
    print("\(mayBeNumber)")
}


struct Animal {
    let special: String
    init?(special: String) {
        if special.isEmpty { return nil }
        self.special = special
    }
}

let someCreature = Animal(special: "Жираф")
if let giraffe = someCreature {
    print("Мы не инеци \(giraffe.special)")
}


let anonymousCreature = Animal(special: "")
if anonymousCreature == nil {
    print("не из")
}



enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "F":
            self = .fahrenheit
        case "K":
        self = .kelvin
        case "C":
            self = .celsius
        default:
            return nil
    }
}
}
let fahrengeitUnit = TemperatureUnit(symbol: "F")
if fahrengeitUnit != nil {
    print("Эта единица измерения")
}
let unknowUnit = TemperatureUnit(symbol: "X")
if unknowUnit == nil {
    print("не знаем")
}

/*

enum TemperatureUnit: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
  
}
let fahrengeitUnit = TemperatureUnit(rawValue: "F")
if fahrengeitUnit != nil {
    print("Эта единица измерения")
}
let unknowUnit = TemperatureUnit(rawValue: "X")
if unknowUnit == nil {
    print("не знаем")
}
*/
