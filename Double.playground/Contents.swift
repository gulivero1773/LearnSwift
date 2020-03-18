import UIKit


extension Double {
    var km: Double { return self * 1000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1000.0 }
    var ft: Double { return self / 3.29 }
    
}


let oneInch = 25.4.mm
print("\(oneInch) ")


let threeFeet = 3.ft
print(threeFeet)



struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRecct = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))


extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - size.width / 2
        let originY = center.y - size.width / 2
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}


let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))








extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions {
    print("Hello")
}



extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 3
someInt.square()
print(someInt)





extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

7434343434[0]


extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind{
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}
