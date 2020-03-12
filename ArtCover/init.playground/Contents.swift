import UIKit


struct Fahrenheit {
    
      var temperature = 32.0
}

var f = Fahrenheit()
print("\(f.temperature)")


struct Celsius {
    var temperaturaInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperaturaInCelsius = (fahrenheit - 32.0) / 1.8
        
    }
    init(fromKelvin kelvin: Double) {
        temperaturaInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperaturaInCelsius = celsius
        
    }
}
let bolingPointOgWater = Celsius(fromFahrenheit: 212.0)
bolingPointOgWater.temperaturaInCelsius


let freeezingPointOfWater = Celsius(fromKelvin: 273.15)
freeezingPointOfWater.temperaturaInCelsius

let bodyTemperature = Celsius(36.6)
bodyTemperature.temperaturaInCelsius






struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)
