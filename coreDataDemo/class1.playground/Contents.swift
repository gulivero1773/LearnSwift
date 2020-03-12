import UIKit

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "движется на скорости  \(currentSpeed) км  в час"
    }
    
    func makeNoise() {
        //
    }
}

let someVehicle = Vehicle()
print("Транспорт: \(someVehicle.description)")
class Bicycle: Vehicle {
var hasBasket = false
    
}

let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Велосипед: \(bicycle.description)")

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
    
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Тандем \(tandem.description)")


class Train: Vehicle {
    override func makeNoise() {
        print("Чух-чух!")
    }
}
let train = Train()
train.makeNoise()

class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " напередаче  \(gear)"
    }
}

let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("машиа \(car.description)")


class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10) + 1
        }
    }
}
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("Машина с автоматом \(automatic.description)")
