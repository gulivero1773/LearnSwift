import UIKit

class Contry {
    let name: String
    var capitalCity: City!
    init(name: String, capitalCity: String) {
        self.name = name
        self.capitalCity = City(name: capitalCity, country: self)
    }
}


class City {
    let name: String
    unowned let country: Contry
    init(name: String, country: Contry) {
        self.name = name
        self.country = country
    }
    
}


var country = Contry(name: "Rus", capitalCity: "Moscva")
print("\(country.name)   \(country.capitalCity.name)")


class HTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = { [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)<\(self.name)>"
        } else {
            return "</\(self.name)>"
        }
    }


init(name: String, text: String? = nil) {
    self.name = name
    self.text = text
}
deinit {
    print("\(name)")
}
}

let heading = HTMLElement(name: "h1")
let defaultText = "some defaul text"
heading.asHTML = {
    return "<\(heading.name)> \(heading.text ?? defaultText) </\(heading.name)>"
}
print(heading.asHTML())



var paragraph: HTMLElement? = HTMLElement(name: "p", text: "Hello world")
print(paragraph!.asHTML())


paragraph = nil
