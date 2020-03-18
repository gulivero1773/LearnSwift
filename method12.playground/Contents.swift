protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruetiaGenerator: RandomNumberGenerator {
   
    var lastRandom = 42.0
    let m = 1233.0
    let a = 32323.0
    let c = 23232.0
    
    
    
    
    
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)).truncatingRemainder(dividingBy: m)
    return lastRandom / m
    }
    
    
}

let generator1 = LinearCongruetiaGenerator()
print("Случайное число \(generator1.random())")



protocol Toggable {
    mutating func toggle()
    
}

enum OnOffSwich: Toggable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        
    }
}
}
var lighSwitch = OnOffSwich.off
lighSwitch.toggle()
print(lighSwitch)


protocol SomeProtocol {
    init()
    
}

class SomeSuperClass {
    init() {
        
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocol {
    required override init() {
        //
    }
}




class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}


var d6 = Dice(sides: 6, generator: LinearCongruetiaGenerator())
for _ in 1...5 {
    print("\(d6.roll())")
}



protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart( _ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func  gameDiDEnd(_ game: DiceGame)
}



protocol TextRepresentable {
    func textualDescription() -> String
}



extension Dice: TextRepresentable {
    func textualDescription() -> String {
        return "Игральная кость с \(sides)"
    }
    
    
}


let d10 = Dice(sides: 10, generator: LinearCongruetiaGenerator())
print(d10.textualDescription())


struct Hamster {
    var name: String
    func textualDescription() -> String {
        return name
    }
}


extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Фруша")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription())


let things: [TextRepresentable] = [ d10, simonTheHamster]

for thing in things {
    print(thing.textualDescription())
}

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}


protocol SomeClassOnlyProtocol: AnyObject {
    
}

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
    
}

struct VipPerson: Named, Aged {
    var name: String
    var age: Int
    
    
}

func wishHappyBirthday( to celebrator: Named & Aged) {
    print(" \(celebrator.name)   \(celebrator.age)")
}


let birthdayPerson = VipPerson(name: "Сшка", age: 21)
wishHappyBirthday(to: birthdayPerson)


protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.2121
    var radius: Double
    var area: Double { return pi * radius * radius}
    init(radius: Double) {
        self.radius = radius
    }
}

class Country: HasArea {
    var area: Double
    init(area: Double) {
        self.area = area
    }
    
}

class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}
let objects: [AnyObject] = [
    Circle(radius: 2.0),
Country(area: 232323),
Animal(legs: 6)]


for object in objects {
    if let objectWithArea = object as? HasArea {
        print( objectWithArea.area)
    } else {
        print ("sds")
    }
}









