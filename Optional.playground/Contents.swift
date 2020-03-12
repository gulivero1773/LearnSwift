import UIKit


class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Нравится ли вам сыр?")
cheeseQuestion.ask()
cheeseQuestion.response = "Да, я люблю сыр"

class ShopListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShopListItem()
struct Size {
    var width = 0.0, height = 0.0
    
}
let twoByTwo = Size(width: 2.0, height: 2.0)

struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - size.width / 2
         let originY = center.y - size.width / 2
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
let basicRect = Rect()
